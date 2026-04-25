#!/usr/bin/env zsh
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  upload-image.zsh <host> <image-path> [retention]

Hosts:
  uguu                  Temporary direct image URL, expires after about 3 hours.
  filebin               Multi-day public URL.
  litterbox [1h|12h|24h|72h]
                        Temporary direct URL. Use only for explicit user-approved uploads.
  bashupload [seconds]  Temporary downloadable URL; may return application/octet-stream.
EOF
}

if [[ $# -lt 2 ]]; then
  usage >&2
  exit 2
fi

host="$1"
image_path="$2"
retention="${3:-}"

if [[ ! -f "$image_path" ]]; then
  print -u2 "Image file not found: $image_path"
  exit 1
fi

mime_type="$(file -b --mime-type "$image_path")"
case "$mime_type" in
  image/png|image/jpeg|image/gif|image/webp|image/svg+xml) ;;
  *)
    print -u2 "Unsupported or unexpected image MIME type: $mime_type"
    exit 1
    ;;
esac

case "$host" in
  uguu)
    response="$(curl -fsS -F "files[]=@${image_path}" https://uguu.se/upload)"
    python3 -c 'import json, sys; print(json.load(sys.stdin)["files"][0]["url"])' <<< "$response"
    ;;
  filebin)
    bin="agent-lab-$(date +%s)-$RANDOM"
    filename="${image_path:t}"
    curl -fsS -X POST "https://filebin.net/${bin}/${filename}" \
      --data-binary "@${image_path}" \
      -H "Content-Type: ${mime_type}" >/dev/null
    print "https://filebin.net/${bin}/${filename}"
    ;;
  litterbox)
    time_value="${retention:-1h}"
    case "$time_value" in
      1h|12h|24h|72h) ;;
      *)
        print -u2 "Invalid Litterbox retention: $time_value"
        print -u2 "Use one of: 1h, 12h, 24h, 72h"
        exit 2
        ;;
    esac
    curl -fsS \
      -F "reqtype=fileupload" \
      -F "time=${time_value}" \
      -F "fileToUpload=@${image_path}" \
      https://litterbox.catbox.moe/resources/internals/api.php
    ;;
  bashupload)
    seconds="${retention:-3600}"
    curl -fsS -H "X-Expiration-Seconds: ${seconds}" -T "$image_path" https://bashupload.app |
      awk '/https?:\/\/[^[:space:]]+/ { print $1; exit }'
    ;;
  *)
    print -u2 "Unknown host: $host"
    usage >&2
    exit 2
    ;;
esac

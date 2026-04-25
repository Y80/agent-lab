# Public Image Host Reference

This reference records public hosts that were tested with a local 1x1 PNG on 2026-04-25. Re-test before relying on them for important work because free public hosts can change limits, uptime, and API behavior without notice.

## Test Image

A harmless local PNG was generated at `/tmp/agent-lab-image-host-test.png` and verified with:

```bash
file /tmp/agent-lab-image-host-test.png
```

Expected result:

```text
PNG image data, 1 x 1, 8-bit gray+alpha, non-interlaced
```

## Uguu

Official site: https://uguu.se/

Observed limits from the homepage: max upload size 128 MiB; files expire after 3 hours.

Upload:

```bash
curl -fsS -F 'files[]=@<image-path>' https://uguu.se/upload
```

The response is JSON. Use the first `files[0].url` value.

Observed successful response shape:

```json
{
  "success": true,
  "files": [
    {
      "filename": "PVRMHyTW.png",
      "url": "https://o.uguu.se/PVRMHyTW.png",
      "size": 68
    }
  ]
}
```

Verification:

```bash
curl -fsSL -o /tmp/check-uguu.png <returned-url>
file /tmp/check-uguu.png
```

Observed verification: HTTP 200, `image/png`, downloaded file recognized as PNG.

Use when:

- A short-lived direct image URL is enough.
- The image is safe to be public for a few hours.

## Filebin

Official site: https://filebin.net/

Official API docs: https://filebin.net/api

Observed behavior from the site: no registration; files in a bin are automatically deleted after several days and can be manually deleted by anyone familiar with the location.

Upload:

```bash
bin="agent-lab-$(date +%s)"
filename="$(basename <image-path>)"
curl -fsS -X POST "https://filebin.net/${bin}/${filename}" \
  --data-binary "@<image-path>" \
  -H "Content-Type: image/png"
```

Public URL:

```text
https://filebin.net/<bin>/<filename>
```

Verification:

```bash
curl -fsSL -o /tmp/check-filebin.png "https://filebin.net/<bin>/<filename>"
file /tmp/check-filebin.png
```

Observed verification: HTTP 200 after redirect, `image/png`, downloaded file recognized as PNG.

Use when:

- A multi-day public URL is useful.
- A direct browser-shareable URL is more important than strict image-host branding.

## Litterbox

Official site: https://litterbox.catbox.moe/

Litterbox is the temporary file host from the Catbox ecosystem. The tested API accepts `1h`, `12h`, `24h`, or `72h` expirations.

Important policy note: Catbox's homepage has warned against using Catbox for agentic AI workflows. Do not use Catbox/Litterbox as the default for autonomous or bulk uploads. Use it only for explicit, one-off user-approved uploads, and prefer Uguu or Filebin when they fit.

Upload:

```bash
curl -fsS \
  -F 'reqtype=fileupload' \
  -F 'time=1h' \
  -F 'fileToUpload=@<image-path>' \
  https://litterbox.catbox.moe/resources/internals/api.php
```

The response is the direct URL, for example:

```text
https://litter.catbox.moe/ndcfr4.png
```

Verification:

```bash
curl -fsSL -o /tmp/check-litterbox.png <returned-url>
file /tmp/check-litterbox.png
```

Observed verification: HTTP 200, `image/png`, downloaded file recognized as PNG.

Use when:

- The user explicitly approves this host.
- A temporary direct image URL with 1h to 72h retention is needed.

## BashUpload

Official site: https://bashupload.app/

Observed behavior from the homepage: command-line upload with `curl -T`; default links are one-time downloads unless an expiration is set with `X-Expiration-Seconds`.

Upload:

```bash
curl -fsS -H 'X-Expiration-Seconds: 3600' -T <image-path> https://bashupload.app
```

The response includes a URL such as:

```text
http://bashupload.app/bp9zhn.bin
```

Verification:

```bash
curl -fsSL -o /tmp/check-bashupload.png <returned-url>
file /tmp/check-bashupload.png
```

Observed verification: HTTP 200, `application/octet-stream`, downloaded file recognized as PNG.

Use when:

- A temporary downloadable file URL is acceptable.
- A direct image MIME type is not required.

Avoid when:

- The URL must render as an image in Markdown or browser embeds.

## Hosts Tested But Not Selected

- `0x0.st`: upload command returned HTTP 503 during local testing, so it was not listed as a verified option.
- `temp.sh`: upload succeeded, but the returned URL downloaded an HTML page in local verification instead of the raw PNG, so it is not recommended as an image URL.
- `file.io`: redirected to the homepage during local testing, so it was not listed as a verified option.


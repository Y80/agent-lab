---
name: upload-public-images
description: Use this skill when uploading local image files to public image/file hosting services and returning shareable URLs. Applies to PNG, JPG, JPEG, GIF, WebP, SVG, screenshots, generated images, temporary public image links, Markdown image URLs, curl-based uploads, and choosing between public temporary hosts such as Uguu, Filebin, Litterbox, and BashUpload.
---

# Upload Public Images

## Workflow

1. Confirm the image is safe to publish. Public image hosts are not private storage; do not upload secrets, personal documents, private screenshots, credentials, customer data, or unreleased company material unless the user explicitly approves that exact file.
2. Prefer temporary hosts for ad hoc sharing. Use permanent or long-lived hosting only when the user asks for it and understands the retention tradeoff.
3. Inspect the file path and type before uploading:

```bash
file <image-path>
ls -lh <image-path>
```

4. Choose a host from [references/hosts.md](references/hosts.md). Prefer a host that was recently verified and returns a direct image URL.
5. Upload with `curl` or `scripts/upload-image.zsh`, then verify the returned URL by downloading it back and checking the content type or file signature.
6. Return the public URL and mention the host, expected retention, and any important limitation.

## Safety Rules

- Never upload a user-provided local image to a public host just for testing. Generate a harmless local test image instead.
- Do not upload anything from hidden config directories, browser profiles, password managers, `.ssh`, `.codex`, `.claude`, `.config`, or company workspaces unless the user explicitly identifies that exact file for public upload.
- Prefer one-off manual uploads over automated bulk uploads. Many free hosts are community resources with rate limits and abuse controls.
- If a host returns HTML, a one-time download link, or `application/octet-stream`, verify whether it still works for the user's intended Markdown/browser use before presenting it as an image URL.
- If the host's terms or homepage says it should not be used for agentic AI workflows, avoid it as a default and use it only after explicit user approval.

## Quick Command

Use the bundled script:

```bash
.agents/skills/upload-public-images/scripts/upload-image.zsh uguu <image-path>
```

Supported hosts:

```text
uguu
filebin
litterbox
bashupload
```

For detailed commands, retention, caveats, and local test results, read [references/hosts.md](references/hosts.md).

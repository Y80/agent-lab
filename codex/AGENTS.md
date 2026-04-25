# User-Level Codex Guide

## Python Tooling

- Prefer `uv` for local Python work on this machine.
- For cross-directory, one-off Python tooling with extra dependencies, use `uv run --with <package> python <script>` instead of installing packages into the global Python environment.
- For skill validation, use:

```bash
uv run --with PyYAML python /Users/lcc/.codex/skills/.system/skill-creator/scripts/quick_validate.py <skill-dir>
```

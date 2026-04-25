# 用户级 Codex 指南

## 偏好

- 使用中文回应和维护说明文档。
- Python 相关任务优先使用 `uv`；跨目录一次性脚本依赖优先用 `uv run --with <package> python <script>`。
- npm 依赖管理工具优先使用 `pnpm`。
- 用户目录路径使用 `~`，不要写成 `/Users/<name>`。
- 把偏好和流程分开：短偏好放在 `AGENTS.md`，详细流程放到独立文档并按需引用。

## 常用命令

- 校验 skill 时使用：

```bash
uv run --with PyYAML python ~/.codex/skills/.system/skill-creator/scripts/quick_validate.py <skill-dir>
```

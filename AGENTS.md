# 用户级 Codex 指南

## Python 工具

- 本机 Python 相关任务优先使用 `uv`。
- 对于跨目录、一次性的 Python 工具脚本，如果需要额外依赖，优先使用 `uv run --with <package> python <script>`，不要把依赖安装到全局 Python 环境。
- 校验 skill 时使用：

```bash
uv run --with PyYAML python /Users/lcc/.codex/skills/.system/skill-creator/scripts/quick_validate.py <skill-dir>
```

## Node.js 工具

- npm 依赖管理工具优先使用 `pnpm`。

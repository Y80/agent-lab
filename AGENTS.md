# 用户级 Codex 指南

## 内容组织

- 把“偏好”和“流程”分开记录。
- 偏好适合写成短句并放在 `AGENTS.md` 中，例如优先使用 `pnpm`、优先使用 `uv`、用户路径使用 `~`。
- 流程适合写到单独文档中，例如如何做代码 review、如何创建 skill、如何整理需求、如何发布版本。
- 当 `AGENTS.md` 只需要按需引用详细流程时，写清楚触发条件和参考文件路径。

## Python 工具

- 本机 Python 相关任务优先使用 `uv`。
- 对于跨目录、一次性的 Python 工具脚本，如果需要额外依赖，优先使用 `uv run --with <package> python <script>`，不要把依赖安装到全局 Python 环境。
- 校验 skill 时使用：

```bash
uv run --with PyYAML python ~/.codex/skills/.system/skill-creator/scripts/quick_validate.py <skill-dir>
```

## 路径书写

- `AGENTS.md` 中所有用户目录路径使用 `~`，不要写成 `/Users/<name>` 形式。

## Node.js 工具

- npm 依赖管理工具优先使用 `pnpm`。

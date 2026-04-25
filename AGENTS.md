# agent-lab 维护指南

## 基本原则

- 使用中文维护本仓库的说明、提交说明、文档和面向用户的输出。
- 遵循 Codex、opencode、AGENTS.md、Skills 等相关工具的官方规范；如果规范不确定，先查官方文档或仓库内已有约定。
- 优先采用通用、可迁移、可版本化的做法，不把只适用于单台机器的临时状态写成长期规则。
- 不要提交 token、密钥、认证文件、日志、会话记录、自动生成的本地记忆、个人隐私信息或公司敏感资料。

## 仓库结构

- `.agents/AGENTS.md` 存放用户级智能体工作约定，例如工具偏好、路径书写规则和长期稳定偏好。
- `.agents/skills/` 存放可复用 Skills。新增或修改 skill 时遵循 skill 官方结构：每个 skill 目录必须包含 `SKILL.md`，可按需包含 `agents/`、`references/`、`scripts/`、`assets/`。
- `README.md` 面向人类读者，说明仓库用途、目录约定和同步方式。
- 根目录 `AGENTS.md` 只描述如何维护本仓库，不放个人工具偏好；个人偏好应写入 `.agents/AGENTS.md`。

## Skills 维护

- 创建或修改 skill 时优先使用 `$skill-creator` 的流程。
- `SKILL.md` 保持精简，详细资料放入同级 `references/`，脚本放入同级 `scripts/`。
- 新增 skill 后必须运行校验：

```bash
uv run --with PyYAML python ~/.codex/skills/.system/skill-creator/scripts/quick_validate.py <skill-dir>
```

- 如果 `uv` 当前不可用，可临时使用已有 Python 环境运行校验，但应在说明中注明原因。
- 技术资料、第三方服务、公开 API 或工具行为可能变化时，必须优先查官方文档，并在 skill 或 reference 中写清楚验证时间和限制。

## Git 约定

- 变更前先查看 `git status --short`，不要覆盖用户未提交的无关文件。
- 提交时只包含本次任务相关文件；不要顺手提交未确认的图片、草稿、缓存或本地生成文件。
- 推送前确认 `main` 与 `origin/main` 的状态，并保留工作区中用户未要求处理的未跟踪文件。

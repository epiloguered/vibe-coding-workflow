# Vibe Coding Workflow

一套面向 Codex 的跨平台、文档优先项目创建工作流。它先通过逐问式需求审问消除关键歧义，再决定九份固定项目文档是否启用，获得确认后才生成文档和实施代码。

## 一句话使用

在 Windows 或 macOS 的 Codex 中发送：

```text
请使用这个工作流创建新项目：
https://github.com/epiloguered/vibe-coding-workflow
```

Codex 应从 [`BOOTSTRAP.md`](BOOTSTRAP.md) 开始，临时加载工作流并创建项目。

## 可选：安装为个人 Skill

在任意新电脑上发送：

```text
请使用 $skill-installer 从下面的 GitHub 仓库安装 vibe-coding-workflow：
https://github.com/epiloguered/vibe-coding-workflow
```

安装后可以直接发送：

```text
使用 $vibe-coding-workflow 创建一个新项目。
```

临时加载不会修改个人 Skill 目录；安装方式会让工作流对这台电脑上的其他项目可用。

## 固定项目文档

每个新项目都会创建以下文件。每份文件必须标记为 `ENABLED` 或 `DISABLED`，并写明原因和重新评估条件。

1. `PRD.md`
2. `APP_FLOW.md`
3. `TECH_STACK.md`
4. `FRONTEND_GUIDELINES.md`
5. `BACKEND_STRUCTURE.md`
6. `IMPLEMENTATION_PLAN.md`
7. `AGENTS.md`
8. `progress.txt`
9. `lessons.md`

未启用的文档仍然保留，但不会填充虚构的规格内容。

## 工作顺序

```text
读取上下文
→ 逐问式需求审问
→ 文档启用清单
→ 用户确认
→ 生成九份文档
→ 确认实施计划
→ 分阶段编码与验证
→ 更新 progress.txt
→ 按条件沉淀 lessons.md
→ 完成验收
```

完整规则位于 [`.agents/skills/vibe-coding-workflow/SKILL.md`](.agents/skills/vibe-coding-workflow/SKILL.md)。

## 手动初始化模板

通常由 Codex 调用脚本。也可以手动执行。

Windows：

```powershell
.\.agents\skills\vibe-coding-workflow\scripts\init-project.ps1 `
  -TargetPath 'C:\Projects\my-project'
```

macOS：

```bash
bash .agents/skills/vibe-coding-workflow/scripts/init-project.sh \
  "$HOME/Developer/my-project"
```

脚本不会覆盖同名文件。使用 `-DryRun` 或 `--dry-run` 可以先预览。

## 仓库验证

Windows：

```powershell
pwsh -File tests/test-init-project.ps1
python tests/validate_repository.py
```

macOS：

```bash
bash tests/test-init-project.sh
python3 tests/validate_repository.py
```

GitHub Actions 会在 Windows 和 macOS 上执行同样的结构与初始化验证。

## 安全与可迁移性

- 仓库中不保存 API Key、登录令牌、SSH 私钥或真实 `.env`。
- 工作流核心使用 Markdown；平台脚本只负责安全地复制模板。
- 项目规则使用相对路径，不写死 Windows 盘符或 Mac 用户目录。
- 新项目的 `AGENTS.md` 记录工作流仓库、版本和提交号，便于审计和升级。

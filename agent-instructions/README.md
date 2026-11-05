# Agent Instructions

Clones [`KingOfKalk/agent-instructions`](https://github.com/KingOfKalk/agent-instructions) (`main`) into a temporary directory and runs `./install.sh all --backup` to install the shared `INSTRUCTIONS.md` for all supported coding agents:

- Claude Code: `~/.claude/CLAUDE.md`
- opencode: `${XDG_CONFIG_HOME:-~/.config}/opencode/AGENTS.md`
- Mistral Vibe: `~/.vibe/AGENTS.md`
- Codex CLI: `~/.codex/AGENTS.md`

An existing file that differs is moved to `<file>.bak.<timestamp>` before being replaced. The temporary clone is removed afterwards.

`test.sh` verifies that all four files exist and are non-empty.

---

[Back](../README.md)

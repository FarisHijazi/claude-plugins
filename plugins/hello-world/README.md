# hello-world

Exhaustive reference plugin exercising every Claude Code plugin feature in a single small package. Built for debugging and learning, not for actual use.

## What it ships

| Feature | File(s) | What it does |
|---|---|---|
| **Plugin manifest** | `.claude-plugin/plugin.json` | Identity + metadata. |
| **Hooks** (6 events) | `hooks/hooks.json` + `hooks/log-event.sh` | Logs every `SessionStart`, `UserPromptSubmit`, `PreToolUse:Bash`, `PostToolUse:Write|Edit`, `Notification`, `Stop` event to `/tmp/hello-world-plugin.log`. |
| **Skill** (model-invoked) | `skills/greet/SKILL.md` | Claude auto-invokes when the user asks for a greeting. |
| **Command** (user-invoked) | `commands/ping.md` | `/hello-world:ping <arg>` — sanity check; logs to the same file. |
| **Subagent** | `agents/greeter.md` | Spawnable agent that produces a friendly 3-line greeting. |
| **MCP server** | `.mcp.json` | Wires up Anthropic's `@modelcontextprotocol/server-everything` reference MCP — gives Claude every demo tool/resource the reference server provides. |
| **Bin executable** | `bin/hello-world-greet` | Added to PATH while plugin is enabled. Try `hello-world-greet Faris`. |
| **Background monitor** | `monitors/monitors.json` | `tail -F /tmp/hello-world-plugin.log` — surfaces every logged event back into Claude's session as notifications. |

## Install

```text
/plugin marketplace add FarisHijazi/claude-plugins
/plugin install hello-world@farishijazi-plugins
```

After install, restart Claude Code (the monitor needs a fresh session to start).

## Things to try

```text
/hello-world:ping smoke test           # command path
"please greet Faris"                   # skill path (model decides to invoke)
"use the greeter agent to greet me"    # subagent path
hello-world-greet Faris                # bin path (Claude can call this in Bash)
```

Then watch the log:

```bash
tail -f /tmp/hello-world-plugin.log
```

You should see every event fire, plus the monitor will surface those log lines back into your Claude session as it tails them.

## File tree

```
hello-world/
├── .claude-plugin/plugin.json
├── .mcp.json
├── README.md
├── hooks/
│   ├── hooks.json
│   └── log-event.sh
├── skills/greet/SKILL.md
├── commands/ping.md
├── agents/greeter.md
├── bin/hello-world-greet
└── monitors/monitors.json
```

## Debugging cheat sheet

| Symptom | Likely cause |
|---|---|
| No events in log | Plugin not enabled. Run `/plugin` and verify `hello-world` shows as enabled. Restart session. |
| Skill not invoked | Skill is model-invoked — Claude only fires it when its `description:` matches the prompt's intent. Ask explicitly: "use the hello-world greet skill on Faris". |
| `hello-world-greet: command not found` | `bin/` PATH only injected when plugin enabled. Verify with `/plugin`. |
| MCP server fails | Needs npx + network. Disable in `.mcp.json` if offline. |
| Monitor not firing | Monitor starts on session start. Restart Claude Code after install. |

## License

MIT.

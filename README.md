# farishijazi-plugins

A Claude Code plugin marketplace by [Faris Hijazi](https://github.com/FarisHijazi).

## Install the marketplace

```text
/plugin marketplace add FarisHijazi/claude-plugins
```

Then browse and install plugins:

```text
/plugin
```

## Plugins

| Plugin | Description |
|---|---|
| [`cc-notify`](./plugins/cc-notify) | Native macOS notifications + click-to-focus for Claude Code. Banners on Notification and Stop events; click jumps to the exact Terminal window, Aerospace workspace, and tmux session/window/pane. |

## Adding a new plugin

1. Create `plugins/<name>/.claude-plugin/plugin.json`
2. Put hooks/skills/agents/commands in the standard subdirectories (see [docs](https://code.claude.com/docs/en/plugins))
3. Add an entry to `.claude-plugin/marketplace.json`
4. Validate: `claude plugin validate plugins/<name>`
5. Commit + push

Users on the latest version then run `/plugin marketplace update` to see the new plugin.

## License

MIT (per-plugin license may differ — see each plugin's directory).

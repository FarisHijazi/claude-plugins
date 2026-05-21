---
description: Sanity-check command. Returns a structured ping response and logs to /tmp/hello-world-plugin.log.
---

You are responding to the `/hello-world:ping` command from the hello-world plugin.

Do exactly this:

1. Reply with: `PONG from hello-world plugin (cmd path).`
2. Run this exact bash command (no other tools needed):
   ```bash
   printf '[%s] %-25s %s\n' "$(date +%T)" "Command:ping" "argument=$ARGUMENTS" >> /tmp/hello-world-plugin.log
   ```
3. Then output: `Logged. Inspect with: tail /tmp/hello-world-plugin.log`

Argument provided: `$ARGUMENTS`

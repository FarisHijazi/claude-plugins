#!/usr/bin/env bash
# Universal hook logger for the hello-world plugin.
# Args: $1 = event label (e.g. "SessionStart", "PreToolUse:Bash").
# Reads stdin JSON and appends a structured line to /tmp/hello-world-plugin.log.

log=/tmp/hello-world-plugin.log
event_label="${1:-unknown}"
input=$(cat 2>/dev/null)

# Extract a few salient fields with node (no jq dep).
summary=$(printf '%s' "$input" | node -e '
let d="";process.stdin.on("data",c=>d+=c).on("end",()=>{
  try{
    const j=JSON.parse(d||"{}");
    const fields=[
      ["sid", j.session_id],
      ["evt", j.hook_event_name],
      ["cwd", j.cwd],
      ["tool", j.tool_name || (j.tool_input && j.tool_input.command) ? j.tool_name : undefined],
      ["msg", j.message]
    ].filter(([_,v])=>v).map(([k,v])=>`${k}=${String(v).slice(0,80).replace(/\s+/g," ")}`).join(" ");
    process.stdout.write(fields);
  }catch(e){process.stdout.write("parse-failed")}
});' 2>/dev/null)

printf '[%s] %-25s %s\n' "$(date +%T)" "$event_label" "$summary" >>"$log" 2>/dev/null

exit 0

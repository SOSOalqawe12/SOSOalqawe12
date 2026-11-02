#!/usr/bin/env bash
# Claude Code "Stop" hook: gives you a free Telegram voice call when Claude finishes.
#
# Uses CallMeBot (free, donation-run): https://www.callmebot.com
# Needs one environment variable (see CALL-ME-SETUP.md):
#   CALL_ME_TELEGRAM     your Telegram username, e.g. @myname
# Optional:
#   CALL_ME_MESSAGE      what the voice says (default below)
#   CALL_ME_VOICE        voice/language code (default en-US-Standard-B)
#
# If CALL_ME_TELEGRAM is not set the hook does nothing, so it never
# blocks or breaks a Claude Code session.

cat >/dev/null   # Claude Code sends hook details on stdin; we don't need them.

[ -n "${CALL_ME_TELEGRAM:-}" ] || exit 0

user="$CALL_ME_TELEGRAM"
case "$user" in @*|+*|[0-9]*) ;; *) user="@$user" ;; esac

curl -sS --fail --max-time 20 -o /dev/null --get \
  "https://api.callmebot.com/start.php" \
  --data-urlencode "user=${user}" \
  --data-urlencode "text=${CALL_ME_MESSAGE:-Hi. Claude has finished your task.}" \
  --data-urlencode "lang=${CALL_ME_VOICE:-en-US-Standard-B}" \
  --data-urlencode "rpt=2" \
  || echo "call-when-done: CallMeBot call failed" >&2

exit 0

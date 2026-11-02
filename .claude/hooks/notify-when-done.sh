#!/usr/bin/env bash
# Claude Code "Stop" hook: sends you a Telegram message from your own bot
# when Claude finishes. Free, uses Telegram's official Bot API.
#
# Needs two environment variables (see NOTIFY-SETUP.md):
#   TELEGRAM_BOT_TOKEN   token from @BotFather, e.g. 123456:ABC-...
#   TELEGRAM_CHAT_ID     your chat id (run .claude/hooks/get-chat-id.sh to find it)
# Optional:
#   NOTIFY_MESSAGE       the message text (default below)
#
# If either required variable is missing the hook does nothing, so it never
# blocks or breaks a Claude Code session.

cat >/dev/null   # Claude Code sends hook details on stdin; we don't need them.

[ -n "${TELEGRAM_BOT_TOKEN:-}" ] && [ -n "${TELEGRAM_CHAT_ID:-}" ] || exit 0

curl -sS --fail --max-time 15 -o /dev/null \
  "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
  --data-urlencode "chat_id=${TELEGRAM_CHAT_ID}" \
  --data-urlencode "text=${NOTIFY_MESSAGE:-✅ Claude has finished your task.}" \
  || echo "notify-when-done: Telegram message failed" >&2

exit 0

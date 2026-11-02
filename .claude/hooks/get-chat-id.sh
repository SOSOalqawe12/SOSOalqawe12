#!/usr/bin/env bash
# Prints your Telegram chat id. First send any message to your bot, then run:
#   TELEGRAM_BOT_TOKEN=123456:ABC-... .claude/hooks/get-chat-id.sh
: "${TELEGRAM_BOT_TOKEN:?Set TELEGRAM_BOT_TOKEN to the token @BotFather gave you}"

ids=$(curl -sS --max-time 15 "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/getUpdates" \
  | grep -o '"chat":{"id":-\{0,1\}[0-9]*' | grep -o -- '-\{0,1\}[0-9]*$' | sort -u)

if [ -z "$ids" ]; then
  echo "No messages found. Send your bot a message in Telegram (e.g. 'hi'), then run this again."
  exit 1
fi
echo "Your TELEGRAM_CHAT_ID: $ids"

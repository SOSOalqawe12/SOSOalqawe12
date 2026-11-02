# Get a Telegram alert when Claude finishes (free)

This repo includes a Claude Code **Stop hook** (`.claude/hooks/notify-when-done.sh`,
wired up in `.claude/settings.json`). Each time Claude finishes replying in this
project, **your own Telegram bot** messages you: "✅ Claude has finished your task."

It uses Telegram's official Bot API. It's free and has no third-party service and no
per-message fees. Until you set the two values below, the hook does nothing.

## 1. Make your bot (2 minutes)

1. In Telegram, open **@BotFather**. Use the real one, with the blue verified check.
2. Send `/newbot`, pick a name, then a username ending in `bot` (e.g. `sosoclaude_bot`).
3. BotFather replies with a **token** like `123456789:AAH...`. Keep it secret.
4. Open your new bot and send it any message, e.g. `hi`. Bots can't message you
   until you message them first.

## 2. Find your chat id

```sh
TELEGRAM_BOT_TOKEN=123456789:AAH... .claude/hooks/get-chat-id.sh
```

It prints `Your TELEGRAM_CHAT_ID: 12345678`.

Or open `https://api.telegram.org/bot<YOUR_TOKEN>/getUpdates` in a browser and
look for `"chat":{"id":12345678`.

## 3. Give Claude Code the two values

| Variable | Value |
|---|---|
| `TELEGRAM_BOT_TOKEN` | Token from BotFather |
| `TELEGRAM_CHAT_ID` | Number from step 2 |
| `NOTIFY_MESSAGE` | *(optional)* Your own message text |

**On your own computer:** add them to your shell profile (`~/.zshrc` or `~/.bashrc`):

```sh
export TELEGRAM_BOT_TOKEN=123456789:AAH...
export TELEGRAM_CHAT_ID=12345678
```

**In Claude Code on the web / the Claude app:** add them as environment variables on
the cloud environment, and allow `api.telegram.org` in the environment's network access.

Never commit the token to this repo. Your profile repo is public.

## 4. Test it

```sh
echo '{}' | .claude/hooks/notify-when-done.sh
```

## Make it hard to miss

In Telegram, open your bot's chat → tap its name → **Notifications** → choose a loud
**custom sound**. Make sure the chat isn't muted.

## Notes

- You get one message each time Claude finishes a reply.
- To turn it off, remove the `Stop` entry from `.claude/settings.json` or unset `TELEGRAM_CHAT_ID`.

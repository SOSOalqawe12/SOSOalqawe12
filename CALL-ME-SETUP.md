# Get a free call when Claude finishes

This repo includes a Claude Code **Stop hook** (`.claude/hooks/call-when-done.sh`,
wired up in `.claude/settings.json`). Each time Claude finishes replying in this
project, the hook uses the free [CallMeBot](https://www.callmebot.com) service to
ring you on **Telegram**. A computer voice says "Hi. Claude has finished your task."

It's a Telegram voice call, not a normal phone call, so you need the Telegram app
(free). No account, credit card or API key needed.

Until you set `CALL_ME_TELEGRAM`, the hook does nothing.

## 1. Set up Telegram (one time)

1. Install Telegram and set a **username** (Settings → Username), e.g. `@myname`.
2. In Telegram, open **@CallMeBot_txtbot** and send `/start` to let CallMeBot call you.
3. In Telegram's Settings → Privacy and Security → Calls, make sure you can receive
   calls. If it's set to "My Contacts", add the bot as a contact.

## 2. Tell Claude Code your username

| Variable | Value |
|---|---|
| `CALL_ME_TELEGRAM` | Your Telegram username, e.g. `@myname` |
| `CALL_ME_MESSAGE` | *(optional)* What the voice says |
| `CALL_ME_VOICE` | *(optional)* Voice code, default `en-US-Standard-B` |

**On your own computer:** add it to your shell profile (`~/.zshrc` or `~/.bashrc`):

```sh
export CALL_ME_TELEGRAM=@myname
```

**In Claude Code on the web / the Claude app:** add it as an environment variable on
the cloud environment, and allow `api.callmebot.com` in the environment's network access.

## 3. Test it

```sh
echo '{}' | .claude/hooks/call-when-done.sh
```

Telegram should ring within a few seconds.

## Notes

- You get one call each time Claude finishes a reply.
- CallMeBot is free and run on donations, so it can be slow or briefly down.
- To turn it off, remove the `Stop` entry from `.claude/settings.json` or unset `CALL_ME_TELEGRAM`.

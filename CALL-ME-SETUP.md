# Get a phone call when Claude finishes

This repo includes a Claude Code **Stop hook** (`.claude/hooks/call-when-done.sh`,
wired up in `.claude/settings.json`). Each time Claude finishes replying in this
project, the hook asks Twilio to call your phone, and a computer voice says
"Hi. Claude has finished your task."

Until you add the settings below, the hook does nothing.

## 1. Set up Twilio (one time)

1. Sign up at <https://www.twilio.com>. A trial account comes with some free credit.
2. Buy a phone number that can make voice calls (Phone Numbers → Buy a number).
3. On a trial account, verify your own mobile number under
   Phone Numbers → Verified Caller IDs. Trial accounts can only call verified numbers.
4. Copy your **Account SID** and **Auth Token** from the Twilio Console home page.

## 2. Give Claude Code the four values

Use phone numbers in international format, e.g. `+15551234567`.

| Variable | Value |
|---|---|
| `TWILIO_ACCOUNT_SID` | Account SID (starts with `AC`) |
| `TWILIO_AUTH_TOKEN` | Auth Token |
| `TWILIO_FROM_NUMBER` | The Twilio number you bought |
| `CALL_ME_NUMBER` | Your own phone number |
| `CALL_ME_MESSAGE` | *(optional)* What the voice says |

**On your own computer:** add them to your shell profile (`~/.zshrc` or `~/.bashrc`):

```sh
export TWILIO_ACCOUNT_SID=AC...
export TWILIO_AUTH_TOKEN=...
export TWILIO_FROM_NUMBER=+1...
export CALL_ME_NUMBER=+1...
```

**In Claude Code on the web / the Claude app:** add them as environment variables
on the cloud environment, and make sure the environment's network access allows
`api.twilio.com`.

Never commit your Auth Token to this repo. Your profile repo is public.

## 3. Test it

```sh
echo '{}' | .claude/hooks/call-when-done.sh
```

Your phone should ring within a few seconds.

## Notes

- The hook runs every time Claude stops and waits for you, so you get one call per finished reply.
- Twilio charges a small amount per call (about a cent or two per minute in the US).
- To turn it off, remove the `Stop` entry from `.claude/settings.json` or unset `CALL_ME_NUMBER`.

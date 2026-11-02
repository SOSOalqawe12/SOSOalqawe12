#!/usr/bin/env bash
# Claude Code "Stop" hook: phones you through Twilio when Claude finishes.
#
# Needs these environment variables (see CALL-ME-SETUP.md):
#   TWILIO_ACCOUNT_SID   your Twilio Account SID (starts with AC...)
#   TWILIO_AUTH_TOKEN    your Twilio Auth Token
#   TWILIO_FROM_NUMBER   the Twilio phone number that places the call, e.g. +15551234567
#   CALL_ME_NUMBER       your own phone number, e.g. +15557654321
# Optional:
#   CALL_ME_MESSAGE      what the voice says (default below)
#
# If any required variable is missing the hook does nothing, so it never
# blocks or breaks a Claude Code session.

cat >/dev/null   # Claude Code sends hook details on stdin; we don't need them.

for v in TWILIO_ACCOUNT_SID TWILIO_AUTH_TOKEN TWILIO_FROM_NUMBER CALL_ME_NUMBER; do
  [ -n "${!v:-}" ] || exit 0
done

message="${CALL_ME_MESSAGE:-Hi. Claude has finished your task.}"
# Escape characters that are special in XML so the message can't break the TwiML.
message=$(printf '%s' "$message" | sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g')

curl -sS --fail --max-time 15 -o /dev/null \
  -u "${TWILIO_ACCOUNT_SID}:${TWILIO_AUTH_TOKEN}" \
  "https://api.twilio.com/2010-04-01/Accounts/${TWILIO_ACCOUNT_SID}/Calls.json" \
  --data-urlencode "To=${CALL_ME_NUMBER}" \
  --data-urlencode "From=${TWILIO_FROM_NUMBER}" \
  --data-urlencode "Twiml=<Response><Say>${message}</Say><Pause length=\"1\"/><Say>${message}</Say></Response>" \
  || echo "call-when-done: Twilio call failed" >&2

exit 0

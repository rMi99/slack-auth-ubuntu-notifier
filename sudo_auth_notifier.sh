#!/bin/bash

# Load Slack Webhook URL from environment variable or a secured file
WEBHOOK_URL="https://hooks.slack.com/services/<SLACK_WEBHOOK_URL>"

# Ensure the webhook URL is not empty
if [ -z "$WEBHOOK_URL" ]; then
  echo "Error: Slack Webhook URL is not set."
  exit 1
fi

# Check if curl is installed
if ! command -v curl &> /dev/null; then
  echo "Error: curl is not installed."
  exit 1
fi

# Gather user details
USER=$(whoami)
HOSTNAME=$(hostname)
IP_ADDRESS=$(hostname -I | awk '{print $1}')
AUTH_DETAILS=$(grep "Accepted" /var/log/auth.log | tail -n 1)

# Construct the message
MESSAGE="User $USER logged into $HOSTNAME ($IP_ADDRESS) at $(date). Last successful login attempt: $AUTH_DETAILS"

# Send message to Slack
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H 'Content-type: application/json' --data "{\"text\":\"$MESSAGE\"}" $WEBHOOK_URL)

# Check the response code
if [ "$RESPONSE" -ne 200 ]; then
  echo "Error: Failed to send message to Slack. Response code: $RESPONSE"
  exit 1
fi

echo "Login alert sent to Slack successfully."

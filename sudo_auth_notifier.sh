#!/bin/bash

# Slack Webhook URL
WEBHOOK_URL="https://hooks.slack.com/services/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"

# Gather user details
USER=$(whoami)
HOSTNAME=$(hostname)
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# Parse logs for successful sudo authentications
AUTH_SUCCESS=$(sudo grep "sudo:.*: session opened" /var/log/auth.log)

# Check if there are successful authentications
if [ -n "$AUTH_SUCCESS" ]; then
    MESSAGE="User $USER on $HOSTNAME ($IP_ADDRESS) successfully executed the following sudo commands:\n$AUTH_SUCCESS"
else
    MESSAGE="No recent successful sudo authentications for user $USER on $HOSTNAME ($IP_ADDRESS)."
fi

# Send message to Slack
curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$MESSAGE\"}" $WEBHOOK_URL

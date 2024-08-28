# Sudo Authentication Notifier

This Bash script monitors successful `sudo` authentications on a Linux system and sends a notification to a specified Slack channel. The notification includes the user details and the `sudo` commands executed.

## Features

- Monitors `/var/log/auth.log` for successful `sudo` authentications.
- Sends notifications to a Slack channel with user details, including the executed `sudo` commands.
- Captures and displays the current user, hostname, and IP address.

## Requirements

- Linux system with `bash` installed.
- Slack webhook URL.
- The script requires `sudo` privileges to access `/var/log/auth.log`.

## Installation

1. Clone the repository or download the script file:

    ```bash
    git clone <repository-url>
    cd <repository-directory>
    ```

2. Update the `WEBHOOK_URL` variable in the script with your Slack webhook URL.

    ```bash
    WEBHOOK_URL="https://hooks.slack.com/services/your-webhook-url"
    ```

3. Make the script executable:

    ```bash
    chmod +x sudo_auth_notifier.sh
    ```

4. Run the script:

    ```bash
    ./sudo_auth_notifier.sh
    ```

## Usage

- **Manual Execution**: Run the script manually to monitor `sudo` authentications and send notifications.
- **Scheduled Execution**: Set up a cron job to run the script at regular intervals.

    Example cron job (runs every 5 minutes):

    ```bash
    */5 * * * * /path/to/sudo_auth_notifier.sh
    ```

## Script Overview

### Variables

- `WEBHOOK_URL`: The Slack webhook URL for sending notifications.
- `USER`: The current user's username.
- `HOSTNAME`: The hostname of the machine.
- `IP_ADDRESS`: The IP address of the machine.

### Logic

1. **Log Parsing**: The script uses `grep` to filter successful `sudo` authentications from `/var/log/auth.log`.
2. **Message Construction**: It builds a message containing the user details and the `sudo` commands executed.
3. **Slack Notification**: The message is sent to the Slack channel using the webhook URL.

## Example Output

```markdown
User `john` on `my-server` (192.168.1.10) successfully executed the following sudo commands:
Aug 28 10:00:00 my-server sudo: john : TTY=pts/1 ; PWD=/home/john ; USER=root ; COMMAND=/usr/bin/apt-get update

#!/bin/bash
#
# Shuts down the host on inactivity.
#
# Designed to be executed as root from a cron job.
# It will power off on the 2nd consecutive run without an active ssh session.
# That prevents an undesirable shutdown when the machine was just started, or on a brief disconnect.
#
# To enable, add this entry to /etc/crontab:
# */5 *   * * *   root    /home/ubuntu/dotfiles/bin/shutdown-if-inactive
#
set -o nounset -o errexit -o pipefail

MARKER_FILE="/tmp/ssh-inactivity-flag"

SSH_STATUS=$(ss | grep ssh | grep ESTAB &>/dev/null && echo active || echo inactive)
CODE_STATUS=$(ss | grep code | grep ESTAB &>/dev/null && echo active || echo inactive)

echo "SSH: $SSH_STATUS CODE: $CODE_STATUS"

if [ "$SSH_STATUS" == "inactive" -a "$CODE_STATUS" == "inactive" ]; then
  if [ -f "$MARKER_FILE" ]; then
    echo "Powering off due to ssh inactivity."
    poweroff  # See https://unix.stackexchange.com/a/196014/56711
  else
    # Create a marker file so that it will shut down if still inactive on the next time this script runs.
    touch "$MARKER_FILE"
  fi
else
  # Delete marker file if it exists
  rm --force "$MARKER_FILE"
fi

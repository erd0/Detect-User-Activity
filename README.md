# Detect User Activity

Detects user activity and shuts down the computer if the mouse has not moved in two hours.

Create a scheduled task to run at 23:00 every night running this script.

When the script runs at 23:00 it will note the X,Y coordinates of the mouse.

The user will receive a notification balloon in the bottom right corner alerting them.

Nothing will happen for an hour.

At 00:00 the script will note the X,Y coordinates of the mouse a second time and compare them to the first.

If the X,Y coordinates are different, the mouse has been moved and the script will take no action. If the X,Y coordinates are the same then the mouse has not moved and the script will make a note of the time.

The script will then begin a countdown timer that will shut the machine off after ten minutes.


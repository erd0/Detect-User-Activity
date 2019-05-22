# Detect User Activity

This script detects user activity and shuts down the computer if the mouse has not moved in one hour. 
The best use of this script would be to run it as a scheduled task at a certain time.

### Script Options

     ● Set the **$Script:RunTime** variable to the number of seconds you want the script to run

     ● Set the **$ShutdownTime** variable to the number of minutes you want the shutdown warning to display

### Example Use & Step-by-Step

     ● Create a scheduled task to run this script at at 23:00 every night.

     ● When the script runs at 23:00 it will note the X,Y coordinates of the mouse and write them to **$env:temp\MousePosition1.txt** .

     ● The user will receive a notification balloon in the bottom right corner alerting them.

     ● Nothing will happen for one hour.

     ● At 00:00 the script will note the X,Y coordinates of the mouse a second time and write them to **$env:temp\MousePosition2.txt** .

     ● The number in both .txt files will be compared. 

     ● If the X,Y coordinates are different, the mouse has been moved and the script will take no action. If the X,Y coordinates are the same then the mouse has not moved and the script begin a countdown timer for ten minutes, alerting the user that they are about to be signed off. After ten minutes the computer is shut down.

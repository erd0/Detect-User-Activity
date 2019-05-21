
$Script:Name             = "Detect User Activity"
$Script:Description      = "Shuts down computers with no user (mouse) activity"
$Script:Version          = "2.0"
$Script:Author           = "Erd0"
$Script:RunTime          = "3600"
$ErrorActionPreference   = 'SilentlyContinue'
$ShutdownTime            = (get-date).AddMinutes(10).ToString("HH:mm")

Clear-Host

Add-Type -AssemblyName System.Windows.Forms

# Functions
    function Notification {
        [CmdletBinding()]
        Param(
        $Title='Checking for activity ...',
        $Text='Please move your mouse if you are still using this computer.',
        $Duration='10000'
        )
        [system.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null
        $balloon = New-Object System.Windows.Forms.NotifyIcon
        $path = Get-Process -id $pid | Select-Object -ExpandProperty Path
        $icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
        $balloon.Icon = $icon
        $balloon.BalloonTipIcon = 'Warning'
        $balloon.BalloonTipTitle = $Title
        $balloon.BalloonTipText = $Text
        $balloon.Visible = $true
        $balloon.ShowBalloonTip($Duration)
        $balloon.dispose()
    }
    
# Alert the User

    Notification

# Check for the X,Y position of the mouse and write to file

    $X1 = [System.Windows.Forms.Cursor]::Position.X
    $Y1 = [System.Windows.Forms.Cursor]::Position.Y
    Set-Variable -Name "MousePosition1" -Value "$X1$Y1"
    $MousePosition1 | Out-File -FilePath $env:temp\MousePosition1.txt

# Wait for a period of time before checking for movement

    Start-Sleep -Seconds $Script:RunTime

# Check for the X,Y position of the mouse and write to file

    $X2 = [System.Windows.Forms.Cursor]::Position.X
    $Y2 = [System.Windows.Forms.Cursor]::Position.Y
    Set-Variable -Name "MousePosition2" -Value "$X2$Y2"
    $MousePosition2 | Out-File -FilePath $env:temp\MousePosition2.txt

# Compare the X,Y position of the two captures

    if ( (Compare-Object (Get-Content $env:temp\MousePosition1.txt) (Get-Content $env:temp\MousePosition2.txt) -IncludeEqual).SideIndicator -eq '==' )
        { 
            # No Activity Detected
            Write-Host "No activity detected." -ForegroundColor Red
            shutdown /s /t 300 /c "No activity has been detected on this computer for two hours.`nIt will be shutdown at $ShutdownTime."
        }
    else
        {
            # Activity Detected
            Write-Host "Activity Detected." -ForegroundColor Blue
        }
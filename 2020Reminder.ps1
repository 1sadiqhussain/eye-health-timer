Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Hidden host form
$hostForm = New-Object System.Windows.Forms.Form
$hostForm.WindowState = "Minimized"
$hostForm.ShowInTaskbar = $false

# Reminder popup
$reminderForm = New-Object System.Windows.Forms.Form
$reminderForm.Width = 420
$reminderForm.Height = 200
$reminderForm.StartPosition = "CenterScreen"
$reminderForm.TopMost = $true
$reminderForm.FormBorderStyle = "FixedDialog"
$reminderForm.MaximizeBox = $false
$reminderForm.MinimizeBox = $false
$reminderForm.Text = "20-20-20 Reminder"
$reminderForm.ShowInTaskbar = $true

# Main message
$label = New-Object System.Windows.Forms.Label
$label.Text = "Look 20 feet away for 20 seconds!"
$label.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$label.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$label.AutoSize = $false
$label.Width = 380
$label.Height = 30
$label.Left = 10
$label.Top = 15
$reminderForm.Controls.Add($label)

# Countdown label
$countdownLabel = New-Object System.Windows.Forms.Label
$countdownLabel.Text = "Time remaining: 20 seconds"
$countdownLabel.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$countdownLabel.ForeColor = [System.Drawing.Color]::DarkBlue
$countdownLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$countdownLabel.AutoSize = $false
$countdownLabel.Width = 380
$countdownLabel.Height = 40
$countdownLabel.Left = 10
$countdownLabel.Top = 50
$reminderForm.Controls.Add($countdownLabel)

$secondsLeft = 20

# Countdown timer
$countdownTimer = New-Object System.Windows.Forms.Timer
$countdownTimer.Interval = 1000

$countdownTimer.Add_Tick({
    $script:secondsLeft--
    if ($script:secondsLeft -ge 0) {
        $countdownLabel.Text = "Time remaining: $script:secondsLeft seconds"
    }
    if ($script:secondsLeft -le 5) {
        $countdownLabel.ForeColor = [System.Drawing.Color]::Red
    }
    if ($script:secondsLeft -eq 0) {
        $countdownLabel.Text = "Time remaining: 0 seconds"
        $countdownTimer.Stop()
        $reminderForm.Hide()
    }
})

# OK button
$okButton = New-Object System.Windows.Forms.Button
$okButton.Text = "OK (Dismiss)"
$okButton.Width = 130
$okButton.Height = 35
$okButton.Left = 50
$okButton.Top = 110
$okButton.BackColor = [System.Drawing.Color]::LightGreen
$okButton.Add_Click({
    $countdownTimer.Stop()
    $reminderForm.Hide()
})
$reminderForm.Controls.Add($okButton)

# STOP button
$stopButton = New-Object System.Windows.Forms.Button
$stopButton.Text = "STOP REMINDERS"
$stopButton.Width = 140
$stopButton.Height = 35
$stopButton.Left = 210
$stopButton.Top = 110
$stopButton.BackColor = [System.Drawing.Color]::LightCoral
$stopButton.Add_Click({
    $countdownTimer.Stop()
    $reminderForm.Close()
    $hostForm.Close()
    [System.Windows.Forms.Application]::Exit()
})
$reminderForm.Controls.Add($stopButton)

# When X is clicked
$reminderForm.Add_FormClosing({
    $countdownTimer.Stop()
    $reminderForm.Close()
    $hostForm.Close()
    [System.Windows.Forms.Application]::Exit()
})

# Native method to show window without stealing focus
$signature = @'
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
'@
$type = Add-Type -MemberDefinition $signature -Name "Win32ShowWindow" -Namespace "Win32Functions" -PassThru

function Show-Reminder {
    $script:secondsLeft = 20
    $countdownLabel.Text = "Time remaining: 20 seconds"
    $countdownLabel.ForeColor = [System.Drawing.Color]::DarkBlue
    
    $reminderForm.Show()
    # SW_SHOWNOACTIVATE = 4 (shows window without stealing focus)
    $type::ShowWindow($reminderForm.Handle, 4)
    
    $countdownTimer.Start()
}

# Main reminder timer — 20 MINUTES
$reminderTimer = New-Object System.Windows.Forms.Timer
$reminderTimer.Interval = 1200000  # 20 minutes

$reminderTimer.Add_Tick({
    $session = Get-Process -Name LogonUI -ErrorAction SilentlyContinue
    if (-not $session) {
        Show-Reminder
    }
})

$reminderTimer.Start()
Show-Reminder

[System.Windows.Forms.Application]::Run($hostForm)
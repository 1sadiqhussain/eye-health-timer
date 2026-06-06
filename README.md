# 20-20-20 Eye Health Timer

A Windows-based PowerShell application that implements the **20-20-20 rule** to help maintain good eye health and reduce digital eye strain.

## What is the 20-20-20 Rule?

The 20-20-20 rule is a simple eye care technique recommended by optometrists:
- Every **20 minutes** of screen time
- Look at something **20 feet away**
- For at least **20 seconds**

This helps reduce eye strain, fatigue, and discomfort from prolonged screen exposure.

## Features

✅ **Automated Reminders** - Pops up every 20 minutes with a friendly reminder
✅ **20-Second Countdown** - Visual timer showing time remaining for your eye break
✅ **Non-Intrusive** - Reminder appears without stealing focus (doesn't minimize other windows)
✅ **User-Friendly Interface** - Clean, simple popup with large, readable text
✅ **Quick Dismiss** - Click "OK" to close and continue working
✅ **Stop Option** - "STOP REMINDERS" button to exit the application
✅ **Administrator Capable** - Can be run with elevated privileges for system-wide reminders
✅ **Color-Coded Urgency** - Countdown text turns red in the final 5 seconds

## System Requirements

- **Windows 7 or later** (tested on Windows 10/11)
- **PowerShell 3.0 or higher**
- **.NET Framework 3.5 or higher** (for Windows Forms)
- **Administrator privileges** (recommended for reliable operation)

## Installation

1. **Clone or download the repository:**
   ```powershell
   git clone https://github.com/1sadiqhussain/eye-health-timer.git
   cd eye-health-timer
   ```

2. **Ensure PowerShell Execution Policy allows script execution:**
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

## Usage

### Run as Administrator (Recommended)

1. Right-click on **PowerShell**
2. Select **Run as administrator**
3. Navigate to the script directory
4. Run the script:
   ```powershell
   .\2020Reminder.ps1
   ```

### Run as Regular User

```powershell
.\2020Reminder.ps1
```

### Creating a Shortcut for Easy Access

**With Administrator Privileges:**

1. Right-click on your desktop → **New** → **Shortcut**
2. Enter this location:
   ```
   powershell.exe -ExecutionPolicy Bypass -File "C:\path\to\2020Reminder.ps1"
   ```
3. Name it: `20-20-20 Eye Health Timer`
4. Right-click the shortcut → **Properties**
5. Go to **Advanced** and check **"Run as administrator"**
6. Click OK and save

## How It Works

### Main Components

| Component | Description |
|-----------|-------------|
| **Reminder Timer** | Triggers every 20 minutes (1,200,000 ms) |
| **Reminder Popup** | 420x200 pixel centered window with instructions |
| **Countdown Timer** | Counts down from 20 seconds, updating every second |
| **Controls** | "OK (Dismiss)" and "STOP REMINDERS" buttons |
| **Focus Preservation** | Uses Win32 API to show window without stealing focus |
| **Session Check** | Detects if user is logged in before showing reminder |

### User Interface

When the reminder triggers:

```
╔════════════════════════════════════════╗
║   20-20-20 Reminder                    ║
╠════════════════════════════════════════╣
║                                        ║
║  Look 20 feet away for 20 seconds!     ║
║                                        ║
║        Time remaining: 15 seconds      ║
║                                        ║
║  [OK (Dismiss)]    [STOP REMINDERS]    ║
╚════════════════════════════════════════╝
```

### Color Indicators

- **Dark Blue** (20-6 seconds) - Normal countdown
- **Red** (5-0 seconds) - Final warning to finish your break

## Keyboard Shortcuts & Controls

| Action | Method |
|--------|--------|
| Dismiss Reminder | Click "OK (Dismiss)" button |
| Stop All Reminders | Click "STOP REMINDERS" button |
| Close Window | Click X button (closes application) |

## Customization

### Change Reminder Interval (20 minutes)

Edit line with `$reminderTimer.Interval`:
```powershell
# Example: 15 minutes = 900000 milliseconds
$reminderTimer.Interval = 900000
```

### Change Break Duration (20 seconds)

Edit the `$secondsLeft` variable:
```powershell
# Example: 30 seconds
$secondsLeft = 30
```

### Change Window Size or Position

Modify these properties:
```powershell
$reminderForm.Width = 420   # Window width in pixels
$reminderForm.Height = 200  # Window height in pixels
$reminderForm.StartPosition = "CenterScreen"  # Position on screen
```

### Change Colors

Modify the `BackColor` and `ForeColor` properties:
```powershell
$countdownLabel.ForeColor = [System.Drawing.Color]::DarkBlue
$okButton.BackColor = [System.Drawing.Color]::LightGreen
$stopButton.BackColor = [System.Drawing.Color]::LightCoral
```

## Best Practices for Eye Health

1. **Follow the 20-20-20 Rule** - Use this timer to stick to it consistently
2. **Adjust Screen Brightness** - Match your environment during breaks
3. **Maintain Proper Distance** - Keep your screen 20-26 inches away
4. **Improve Lighting** - Reduce glare and shadows around your workspace
5. **Blink Regularly** - Blinking helps keep eyes moist
6. **Use Blue Light Filters** - Consider glasses or screen filters for long sessions

## Troubleshooting

### Script Won't Run

**Error:** `"File cannot be loaded because running scripts is disabled"`

**Solution:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Reminder Not Showing

**Possible Causes:**
- Not running as administrator
- Script was stopped unintentionally
- Session locked (LogonUI detected)

**Solution:** Restart the script with administrator privileges

### Reminder Window Appearing Behind Other Windows

The script includes `ShowWindow` with `SW_SHOWNOACTIVATE` (value 4) to prevent focus theft, but the window should still appear on top with `TopMost = $true`.

If issues persist, try clicking on the taskbar icon or check if a maximized window is blocking the view.

## Contributing

Contributions are welcome! Feel free to:
- Report bugs and issues
- Suggest features
- Submit pull requests with improvements
- Share feedback on eye health benefits

## License

This project is open source and available under the **MIT License**.

See `LICENSE` file for details.

## Author

**Sadiq Hussain** (@1sadiqhussain)

---

## Eye Health Resources

- [American Optometric Association - Computer Vision Syndrome](https://www.aoa.org/healthy-eyes/eye-and-vision-conditions/computer-vision-syndrome)
- [Mayo Clinic - Eye Strain](https://www.mayoclinic.org/diseases-conditions/eyestrain/symptoms-causes/syc-20372397)
- [The 20-20-20 Rule Explained](https://www.allaboutvision.com/cvs/20-20-20-rule/)

---

**Stay healthy, blink often, and remember to look away! 👀**
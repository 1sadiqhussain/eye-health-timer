# Quick Start Guide

## 🚀 Get Started in 2 Minutes

### Step 1: Run as Administrator

1. Right-click **PowerShell**
2. Select **Run as Administrator**
3. Navigate to the script folder:
   ```powershell
   cd C:\path\to\eye-health-timer
   ```

### Step 2: Allow Script Execution

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Step 3: Run the Timer

```powershell
.\2020Reminder.ps1
```

✅ **Done!** The timer will start and remind you every 20 minutes.

---

## 📌 Create Desktop Shortcut

**Easiest way to run the timer:**

1. Right-click desktop → **New** → **Shortcut**
2. Paste this:
   ```
   powershell.exe -ExecutionPolicy Bypass -NoProfile -WindowStyle Hidden -File "C:\path\to\2020Reminder.ps1"
   ```
3. Name it: `20-20-20 Eye Timer`
4. Right-click → **Properties** → **Advanced** → Check ✓ **Run as administrator**
5. Click **OK** and save

Now just double-click the shortcut to start!

---

## 🔧 Customize

Edit `2020Reminder.ps1` to change:

- **Interval**: Change `1200000` to different milliseconds
  - 15 min = 900000
  - 30 min = 1800000
  
- **Break Duration**: Change `$secondsLeft = 20` to desired seconds

- **Colors**: Modify `[System.Drawing.Color]::DarkBlue`, etc.

---

## ❓ Troubleshooting

| Problem | Solution |
|---------|----------|
| Script won't run | Run PowerShell as Administrator |
| "Cannot load script" error | Run: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` |
| Reminder not appearing | Restart script with admin privileges |

---

## 👀 Eye Health Tips

✅ Keep screen 20-26 inches away  
✅ Blink regularly  
✅ Reduce screen glare  
✅ Use blue light filter glasses  
✅ Follow the **20-20-20 rule** with this timer!

---

**Happy coding! Your eyes will thank you! 👓**
# 🧹 TECNO SPARK 40C Debloat Scripts

This repo provides **two simple, reversible Bash scripts** to:

- Remove **TECNO/Transsion-specific bloat** (e.g., CarlCare, HiBrowser, Tecno apps, Facebook)
- Remove **Google Apps (GApps)** you don’t use (e.g., YouTube, Maps, Gmail, Photos)

✅ **No root required**
✅ **Fully reversible** — restore any app anytime
✅ **Preserves core functionality** — messaging & keyboard **not removed**

---

## 📦 Included Scripts

| Script                                   | Purpose                                        |
| ---------------------------------------- | ---------------------------------------------- |
| [`debloat-tecno.sh`](./debloat-tecno.sh) | Removes Tecno/Transsion/Facebook bloat         |
| [`debloat-gapps.sh`](./debloat-gapps.sh) | Removes Google apps (except Gboard & Messages) |

Both support:

```bash
./script.sh remove    # uninstall apps (for current user)
./script.sh restore   # re-enable them later
```

---

## 🚀 Quick Start (Fedora Linux)

1. **Enable Developer Options & USB Debugging** on your phone
   (`Settings → My Phone → Version Info → Tap "Build Number" 7 times`)

2. Install ADB (if not already installed):

   ```bash
   sudo dnf install android-tools
   ```

3. Clone and run:

   ```bash
   git clone https://github.com/your-username/tecno-spark-40c-debloat.git
   cd tecno-spark-40c-debloat
   chmod +x *.sh
   ```

4. Connect your phone via USB,

   ```bash
   adb devices
   ```

   **allow debugging**, then:

   ```bash
   ./debloat-tecno.sh remove
   ./debloat-gapps.sh remove
   ```

5. **Reboot** your device to finalize changes:
   ```bash
   adb reboot
   ```

---

## ⚠️ Warnings

- **Backup important data** before debloating.
- Restoring apps requires the original system APKs to still exist (they do unless you’ve reflashed or rooted).

---

## 🔁 How Restoration Works

These scripts **do not delete** system apps — they only hide them for your user profile.
To restore, we use:

```bash
adb shell cmd package install-existing <package.name>
```

This re-enables the system app without reflashing.

---

## 📝 Notes

- Based on safe package lists from similar Tecno devices (e.g., Pova 5 Pro).

---

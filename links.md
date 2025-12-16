# 🔒 Privacy & Performance Tweaks

## 🧑‍💻 Replace GBoard with a Privacy-Respecting Keyboard

**Recommended**: [**HeliBoard**](https://github.com/Helium314/HeliBoard)

- ✅ 100% **offline** — no internet permission
- ✅ Open-source (GPLv3)
- ✅ Custom themes, layouts, dictionaries, clipboard history
- ✅ Glide typing support (via optional closed-source library)

### 🔧 Disable Google Keyboard (GBoard)

```bash
adb shell pm clear com.google.android.inputmethod.latin
adb shell pm disable-user --user 0 com.google.android.inputmethod.latin
```

> 💡 This removes GBoard from the input method list and deletes all stored typing data, learned words, and settings.

---

## 🌐 Replace Chrome with a Privacy-Focused Browser

**Recommended**: [**Cromite**](https://github.com/uazo/cromite)

- ✅ Built-in **ad blocker** and **privacy protections**
- ✅ Based on **Bromite** (Chromium fork)
- ✅ No Google integration, anti-fingerprinting mitigations

> 🔐 **Note**: While not a Tor-level anonymity tool, Cromite significantly reduces tracking compared to stock Chrome or manufacturer browsers.

---

## Replace Telegram with a Third-Party Client

**Recommended**: [**Nagram**](https://github.com/NextAlone/Nagram)

- Nagram is a third-party Telegram client based on NekoX with some modifications.

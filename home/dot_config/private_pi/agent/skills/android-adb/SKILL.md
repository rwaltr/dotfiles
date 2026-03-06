---
name: android-adb
description: Android device control via ADB - screenshots, UI interaction, app management, file transfer, and backup/restore using adb and uiautomator
---

# Android ADB

Use this skill when interacting with Android devices over USB via ADB — taking screenshots, navigating UI, transferring files, managing apps, or performing backups.

## Activation Triggers

Activate this skill when the user mentions:
- ADB, Android Debug Bridge
- Controlling or automating an Android phone
- Taking screenshots of a phone
- Installing or managing Android apps
- Transferring files to/from Android
- Backing up or restoring Android data
- Interacting with a phone's UI programmatically

## Environment

- **Binary**: `adb` (from `android-tools` package)
- **Install**: `sudo pacman -S android-tools` (Arch/CachyOS)
- **Prerequisites**: USB Debugging enabled on device (Developer Options)
- **Multiple devices**: Use `-s <serial>` to target a specific device

## Device Management

```bash
# List connected devices
adb devices

# Target a specific device
adb -s <serial> <command>

# Get device serial numbers only
adb devices | grep -v "List" | awk '{print $1}'

# Restart ADB server
adb kill-server && adb start-server

# Connect over TCP/IP (e.g. over Tailscale)
adb connect <ip>:5555
adb tcpip 5555  # switch device to TCP mode first (requires USB)
```

## Screenshots

Screenshots can be taken and pulled to the local machine. The agent CAN VIEW these screenshots using the Read tool.

```bash
# Take screenshot and pull to local machine
adb -s <serial> shell screencap -p /sdcard/screen.png
adb -s <serial> pull /sdcard/screen.png /tmp/screen.png

# One-liner
adb shell screencap -p /sdcard/screen.png && adb pull /sdcard/screen.png /tmp/screen.png
```

**Important**: After pulling, use the `read` tool on the local path to view the screenshot. Image coordinates in the displayed image may be scaled — multiply by the scale factor shown to get actual device coordinates.

## UI Interaction

### Tapping & Input

```bash
# Tap at coordinates (use screenshot to find coordinates)
adb shell input tap <x> <y>

# Long press
adb shell input swipe <x> <y> <x> <y> 1000

# Swipe
adb shell input swipe <x1> <y1> <x2> <y2> [duration_ms]

# Type text
adb shell input text "hello world"

# Key events
adb shell input keyevent 4     # Back
adb shell input keyevent 3     # Home
adb shell input keyevent 187   # Recents
adb shell input keyevent 26    # Power
```

### UI Hierarchy (Blind Navigation)

Use `uiautomator dump` to understand what's on screen without seeing it:

```bash
# Dump UI to file and pull
adb shell uiautomator dump /sdcard/ui.xml
adb pull /sdcard/ui.xml /tmp/ui.xml
cat /tmp/ui.xml | grep -o 'text="[^"]*"\|bounds="[^"]*"' | paste - -
```

Parse bounds format `[x1,y1][x2,y2]` to find tap center:
- center_x = (x1 + x2) / 2
- center_y = (y1 + y2) / 2

### Launch Apps

```bash
# Launch app by package name
adb shell monkey -p <package> -c android.intent.category.LAUNCHER 1

# Launch specific activity
adb shell am start -n <package>/<activity>

# Open URL
adb shell am start -a android.intent.action.VIEW -d "https://example.com"
```

## App Management

```bash
# List installed user apps
adb shell pm list packages -3

# List all packages
adb shell pm list packages

# Install APK
adb install app.apk
adb install -r app.apk  # reinstall, keep data

# Uninstall
adb uninstall <package>

# Clear app data
adb shell pm clear <package>

# Get app version
adb shell dumpsys package <package> | grep versionName
```

## File Transfer

```bash
# Push file to device
adb push local_file.txt /sdcard/

# Pull file from device
adb pull /sdcard/file.txt ./

# Pull entire directory
adb pull /sdcard/DCIM/ ./DCIM/

# List directory
adb shell ls /sdcard/
```

## Backup & Restore

```bash
# Backup specific app data (no APK)
adb backup -noapk <package> -f backup.ab

# Backup multiple apps
adb backup -noapk <pkg1> <pkg2> -f backup.ab

# Full backup
adb backup -all -f full_backup.ab

# Restore
adb restore backup.ab
```

**Note**: User must confirm backup/restore on device screen. `adb backup` is deprecated but still functional as of Android 16.

## SMS / Telephony

```bash
# Backup SMS database
adb backup -noapk com.android.providers.telephony -f sms_backup.ab

# Restore SMS to another device
adb -s <target_serial> restore sms_backup.ab
```

## Shell Access

```bash
# Interactive shell
adb shell

# Run single command
adb shell <command>

# Device info
adb shell getprop ro.product.model
adb shell getprop ro.build.version.release
adb shell getprop ro.build.version.sdk

# Storage info
adb shell df -h

# Running processes
adb shell ps -A | grep <name>
```

## Logcat

```bash
# Stream logs
adb logcat

# Filter by tag
adb logcat -s MyTag

# Filter by priority
adb logcat *:E  # errors only

# Clear log buffer
adb logcat -c
```

## Screen Recording

```bash
adb shell screenrecord /sdcard/record.mp4
# Ctrl+C to stop, then:
adb pull /sdcard/record.mp4 ./
```

## Common Workflows

### Navigate an App Blindly

1. Take screenshot → pull → read to see current state
2. Dump UI hierarchy to find element coordinates
3. Tap element by calculated center coordinates
4. Repeat

### Diff Apps Between Two Devices

```bash
comm -23 \
  <(adb -s <serial1> shell pm list packages -3 | sed 's/package://' | sort) \
  <(adb -s <serial2> shell pm list packages -3 | sed 's/package://' | sort)
```

### Migrate SMS Between Phones

```bash
# On source phone (plugged in via USB)
adb -s <source> backup -noapk com.android.providers.telephony -f sms_backup.ab
# Confirm on device screen

# Switch USB to target phone
adb -s <target> restore sms_backup.ab
# Confirm on device screen
```

## GrapheneOS Notes

- USB debugging must be explicitly enabled in Developer Options
- GrapheneOS restricts `adb backup` for some system apps — user apps work fine
- `adb shell run-as <package>` may not work without app being debuggable
- USB data blocked when screen locked by default — unlock before connecting

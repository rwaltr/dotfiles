---
name: brave
description: Brave browser via Flatpak - launching, remote debugging via CDP, profile management, and Flatpak sandbox considerations
---

# Brave Browser (Flatpak)

Use this skill when working with Brave browser installed via Flatpak — launching it, enabling remote debugging (CDP), or working around Flatpak sandbox constraints.

## Activation Triggers

Activate this skill when the user mentions:
- Brave browser operations
- Launching Brave with specific flags
- Chrome DevTools Protocol (CDP) with Brave
- Brave remote debugging port
- Flatpak browser sandboxing issues
- Connecting Playwright or other tools to a running Brave instance

## Environment

- **Flatpak ID**: `com.brave.Browser`
- **Installation**: system (`/var/lib/flatpak/app/com.brave.Browser/`)
- **Exported wrapper**: `/var/lib/flatpak/app/com.brave.Browser/current/active/export/bin/com.brave.Browser`
  - This wrapper just runs: `flatpak run --branch=stable --arch=x86_64 com.brave.Browser "$@"`
- **Version**: 1.87.x (check with `flatpak info com.brave.Browser`)
- **Sandbox permissions**: `network`, `ipc`, `x11`, `wayland`, `filesystems=host-etc,/tmp,...`

## Launching Brave

### Normal launch

```bash
flatpak run com.brave.Browser
# or via exported bin (if on PATH):
com.brave.Browser
```

### With a specific URL

```bash
flatpak run com.brave.Browser https://example.com
```

### With a specific profile directory

```bash
flatpak run com.brave.Browser --user-data-dir=/tmp/brave-session
```

Note: `/tmp` is accessible inside the Flatpak sandbox per its permissions.

## Remote Debugging (CDP)

### Launch with CDP enabled

```bash
flatpak run com.brave.Browser \
  --remote-debugging-port=9222 \
  --user-data-dir=/tmp/brave-debug
```

- `--remote-debugging-port=9222` — opens the CDP endpoint at `http://localhost:9222`
- `--user-data-dir` — use a temp dir to avoid conflicts with your main Brave profile
- `--no-sandbox` is **not needed** — Flatpak provides its own sandbox

### Verify CDP is running

```bash
curl http://localhost:9222/json/version
```

Expected output includes `webSocketDebuggerUrl` and browser version info.

### List open targets (tabs/pages)

```bash
curl http://localhost:9222/json
```

### Headless mode

```bash
flatpak run com.brave.Browser \
  --headless \
  --remote-debugging-port=9222 \
  --user-data-dir=/tmp/brave-headless
```

## Connecting Playwright via CDP

Once Brave is running with `--remote-debugging-port=9222`:

```javascript
const { chromium } = require('playwright');

const browser = await chromium.connectOverCDP('http://localhost:9222');
const context = browser.contexts()[0];
const page = context.pages()[0];
// Note: use browser.close() to disconnect from CDP (not browser.disconnect())

// Interact with the existing session
await page.goto('https://example.com');
```

Or using the Playwright CLI to open a page in the running instance:

```bash
npx playwright cr --channel=chrome http://localhost:9222
```

See the **playwright-cli** skill for full Playwright CLI usage.

## Flatpak Sandbox Notes

### Filesystem access

The sandbox allows:
- `/tmp` — safe place for temp user data dirs and sockets
- `~/.local/share/applications` (create) — for desktop integration
- `xdg-download` — downloads folder
- `host-etc` — read-only host `/etc` access

### Network

- Full network access is granted (`shared=network`)
- CDP port `9222` is accessible on `localhost` from the host without any extra flags

### Wayland / X11

- Both `wayland` and `x11` sockets are available
- Runs on Wayland natively; falls back to XWayland if needed

### Overriding sandbox permissions (if needed)

```bash
# Grant access to an additional host path
flatpak override --user --filesystem=/home/rwaltr/Downloads com.brave.Browser

# Run with a temporary extra permission
flatpak run --filesystem=/some/path com.brave.Browser
```

## Profile Management

Brave stores profiles inside the Flatpak container at:
```
~/.var/app/com.brave.Browser/config/BraveSoftware/Brave-Browser/
```

For automation, always use `--user-data-dir=/tmp/<name>` to isolate from your real profile.

## Common Patterns

### Quick CDP session for Playwright

```bash
# Terminal 1: launch Brave with CDP
flatpak run com.brave.Browser \
  --remote-debugging-port=9222 \
  --user-data-dir=/tmp/playwright-brave

# Terminal 2: verify
curl -s http://localhost:9222/json/version | jq .Browser
```

### Headless screenshot via CDP + Playwright

```bash
flatpak run com.brave.Browser --headless --remote-debugging-port=9222 --user-data-dir=/tmp/brave-hs &
sleep 2
npx playwright screenshot --browser=chromium http://localhost:9222 out.png
```

## Related Skills

- **playwright-cli**: Use Playwright CLI to drive or connect to Brave

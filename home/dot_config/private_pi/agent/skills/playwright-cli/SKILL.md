---
name: playwright-cli
description: Playwright CLI for browser automation, code generation, screenshots, tracing, and test running via npx playwright
---

# Playwright CLI

There are **two distinct tools** — use the right one for the job:

| Tool | Binary | Best for |
|------|--------|----------|
| `playwright-cli` | `~/.local/share/mise/installs/node/25.3.0/bin/playwright-cli` | Live browser automation, connecting to existing sessions, interactive CLI control |
| `npx playwright` | via mise/npx | Test running, codegen recording, tracing, CI |

---

## `playwright-cli` — Interactive CLI Automation

### Activation Triggers
- Automating an existing logged-in browser session
- Clicking/filling forms without writing scripts
- Connecting to a running Brave/Chrome via CDP
- Any browser task that benefits from step-by-step CLI control

### Connecting to Existing Brave Session (CDP)

Create a config file to point at the running Brave CDP endpoint:

```json
// playwright-cli.json  (in cwd, or specify with --config)
{
  "browser": {
    "cdpEndpoint": "http://localhost:9222"
  }
}
```

Then all `playwright-cli` commands talk to the live Brave session automatically. No scripts needed.

Alternatively use the env var: `PLAYWRIGHT_MCP_CDP_ENDPOINT=http://localhost:9222 playwright-cli snapshot`

### Core Workflow: snapshot → click

```bash
playwright-cli snapshot              # get current page state + element refs (e1, e2, ...)
playwright-cli click e42             # click element by ref
playwright-cli click 'text=Submit'   # click by text
playwright-cli fill e7 "hello"       # fill input by ref
playwright-cli screenshot            # screenshot current page
playwright-cli go-back               # navigate back
playwright-cli goto https://...      # navigate to URL
playwright-cli eval "document.title" # run JS on page
playwright-cli run-code "<playwright code snippet>"  # run arbitrary Playwright JS
```

**Always `snapshot` first** — it returns element refs (e1, e2, ...) and page structure so you know exactly what to click without guessing selectors.

### All Core Commands

```bash
playwright-cli open [url]            # open browser
playwright-cli goto <url>            # navigate
playwright-cli close                 # close page
playwright-cli snapshot              # capture page snapshot → element refs
playwright-cli click <ref>           # click element
playwright-cli dblclick <ref>        # double click
playwright-cli fill <ref> <text>     # fill input
playwright-cli type <text>           # type into focused element
playwright-cli hover <ref>           # hover
playwright-cli select <ref> <val>    # dropdown select
playwright-cli check <ref>           # check checkbox/radio
playwright-cli uncheck <ref>         # uncheck
playwright-cli drag <ref1> <ref2>    # drag and drop
playwright-cli press <key>           # keyboard: 'Enter', 'Tab', 'ArrowLeft'
playwright-cli keydown / keyup <key>
playwright-cli mousemove <x> <y>
playwright-cli mousewheel <dx> <dy>
playwright-cli eval <func> [ref]     # evaluate JS
playwright-cli run-code <code>       # run playwright code snippet
playwright-cli dialog-accept [text]  # accept dialog
playwright-cli dialog-dismiss        # dismiss dialog
playwright-cli resize <w> <h>        # resize window
```

### Tabs

```bash
playwright-cli tab-list
playwright-cli tab-new [url]
playwright-cli tab-select <index>
playwright-cli tab-close [index]
```

### Sessions (Multiple Browsers)

```bash
playwright-cli -s=myapp open https://example.com   # named session
playwright-cli -s=myapp snapshot
playwright-cli list                                  # list all sessions
playwright-cli close-all
playwright-cli kill-all                              # force kill stale sessions
```

Use `PLAYWRIGHT_CLI_SESSION=name` env var to set session for all commands.

### Visual Dashboard

```bash
playwright-cli show    # opens live screencast dashboard of all sessions
```

Lets you watch and take over control from any running session.

### Save / Screenshot

```bash
playwright-cli screenshot                        # stdout
playwright-cli screenshot --filename=out.png     # save to file
playwright-cli screenshot e5                     # screenshot specific element
playwright-cli pdf --filename=page.pdf
```

### Storage & State

```bash
playwright-cli state-save auth.json     # save cookies + localStorage
playwright-cli state-load auth.json     # restore auth state
playwright-cli cookie-list
playwright-cli cookie-set name value
playwright-cli localstorage-list
playwright-cli localstorage-set key val
```

### Config File (`playwright-cli.json`)

Full config schema highlights:

```json
{
  "browser": {
    "cdpEndpoint": "http://localhost:9222",
    "browserName": "chromium",
    "userDataDir": "/tmp/my-profile",
    "launchOptions": { "headless": false }
  },
  "outputDir": "./playwright-output",
  "outputMode": "file",
  "timeouts": {
    "action": 5000,
    "navigation": 60000
  }
}
```

---

## `npx playwright` — Test Runner & Codegen

### Activation Triggers
- Writing/running Playwright tests (`.spec.ts`)
- Recording codegen scripts
- CI pipelines
- Trace viewer

### Code Generation

```bash
npx playwright codegen https://example.com
npx playwright codegen --target=javascript -o actions.js https://example.com
npx playwright codegen --browser=firefox https://example.com
```

### Screenshots & PDF

```bash
npx playwright screenshot --full-page https://example.com full.png
npx playwright pdf https://example.com output.pdf
```

### Test Running

```bash
npx playwright test
npx playwright test tests/login.spec.ts
npx playwright test --project=chromium
npx playwright test --headed
npx playwright test --ui
npx playwright test --trace on
npx playwright show-report
```

### Tracing

```bash
npx playwright show-trace trace.zip
```

### Browser Installation

```bash
npx playwright install
npx playwright install chromium
npx playwright install --with-deps chromium
```

---

## Connecting to Existing Brave Session (Node.js scripts)

When you need full Playwright API control in a script (e.g., loops, complex logic):

```javascript
// Must run from a dir with playwright installed: cd /tmp/play_test && npm install playwright
const { chromium } = require('playwright');

const browser = await chromium.connectOverCDP('http://localhost:9222');
const context = browser.contexts()[0];
const page = context.pages()[0];
// ... interact with page
await browser.close(); // disconnects, does not close Brave
```

**Note**: `playwright` is not globally installed. Either:
- Run from `/tmp/play_test/` (has it installed)
- Or use `playwright-cli` with CDP config instead — no scripting needed

---

## Best Practices

- **Prefer `playwright-cli` + CDP config** over writing Node.js scripts for live session automation — it's faster and requires no boilerplate
- **Always `snapshot` before clicking** — gets accurate element refs, avoids selector guessing
- **Use `playwright-cli show`** to visually monitor what the automation is doing
- Use `npx playwright codegen` to bootstrap test scripts, then refine manually
- Use `--trace on` during test development for failure debugging

## Related Skills

- **brave**: Launch Brave (Flatpak) with remote debugging for CDP connection (`--remote-debugging-port=9222`)

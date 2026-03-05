---
name: playwright-cli
description: Playwright CLI for browser automation, code generation, screenshots, tracing, and test running via npx playwright
---

# Playwright CLI

Use this skill when working with Playwright from the command line — codegen, screenshots, testing, tracing, or scripting browser automation.

## Activation Triggers

Activate this skill when the user mentions:
- Playwright codegen, screenshots, or PDF generation
- Running or writing Playwright tests
- Playwright tracing or trace viewer
- Browser automation scripting
- `npx playwright` commands
- Connecting Playwright to an existing browser (CDP)

## Environment

- **Binary**: `~/.local/share/mise/installs/node/25.3.0/bin/playwright-cli`
- **Invoke via**: `npx playwright <command>` (preferred) or `playwright-cli`
- **Version**: 1.58.x (check with `npx playwright --version`)
- **Node managed by**: `mise`

## Core Commands

### Browser Shortcuts

```bash
npx playwright cr [url]    # Open Chromium
npx playwright ff [url]    # Open Firefox
npx playwright wk [url]    # Open WebKit
npx playwright open [url]  # Open with default browser (-b flag to specify)
```

### Code Generation

```bash
# Record user actions and output code
npx playwright codegen https://example.com

# Specify output file
npx playwright codegen --target=javascript -o actions.js https://example.com

# Codegen with specific browser
npx playwright codegen --browser=firefox https://example.com

# Codegen with viewport size
npx playwright codegen --viewport-size=1280,720 https://example.com
```

### Screenshots & PDF

```bash
# Screenshot
npx playwright screenshot https://example.com screenshot.png

# Full-page screenshot
npx playwright screenshot --full-page https://example.com full.png

# PDF (Chromium only)
npx playwright pdf https://example.com output.pdf
```

### Testing

```bash
# Run all tests
npx playwright test

# Run specific test file
npx playwright test tests/login.spec.ts

# Run with specific browser
npx playwright test --project=chromium

# Run in headed mode (visible browser)
npx playwright test --headed

# Run with debug UI
npx playwright test --ui

# Run with trace
npx playwright test --trace on

# Show HTML report
npx playwright show-report

# Merge sharded reports
npx playwright merge-reports ./blob-reports
```

### Tracing

```bash
# Show trace file
npx playwright show-trace trace.zip
```

### Installation

```bash
# Install browsers for current playwright version
npx playwright install

# Install specific browser
npx playwright install chromium
npx playwright install firefox webkit

# Install browser + system deps
npx playwright install --with-deps chromium

# Install deps only (sudo required)
npx playwright install-deps

# Uninstall playwright browsers
npx playwright uninstall
```

### Cache

```bash
npx playwright clear-cache
```

## Connecting to an Existing Browser (CDP)

Playwright can attach to a running browser via Chrome DevTools Protocol instead of launching its own:

```javascript
const { chromium } = require('playwright');

const browser = await chromium.connectOverCDP('http://localhost:9222');
const context = browser.contexts()[0];
const page = context.pages()[0];
```

See the **brave** skill for launching Brave with CDP enabled.

## Common Patterns

### Quick Screenshot of a URL

```bash
npx playwright screenshot --full-page https://example.com out.png
```

### Record and Save Codegen Script

```bash
npx playwright codegen -o script.js https://myapp.local
```

### Debug a Failing Test

```bash
npx playwright test --debug tests/login.spec.ts
```

### Run Tests Headlessly in CI

```bash
npx playwright test --reporter=github
```

## Best Practices

- Use `npx playwright` to ensure the right version is picked up by mise
- Prefer `connectOverCDP` over launching a new browser when you need to interact with an existing session (e.g., logged-in Brave)
- Use `--trace on` during development to capture detailed failure info
- Store traces/screenshots in a project-local `test-results/` directory
- Use `codegen` to bootstrap test scripts, then refine manually

## Related Skills

- **brave**: Launch Brave (Flatpak) with remote debugging for CDP connection

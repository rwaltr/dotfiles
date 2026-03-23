---
name: brave-search
description: Web search, context extraction, and AI answers via Brave Search API (bx CLI). Use when you need to search the web, look up documentation, research errors, check latest releases, find discussions, or get AI-synthesized answers with citations.
---

# Brave Search CLI (bx)

## Tool

`bx` — installed via mise (`github:brave/brave-search-cli`). Single static binary, JSON output.

## Command Selection

| Need | Command | Why |
|------|---------|-----|
| Docs, errors, code patterns | `bx context` | Pre-extracted text, token-budgeted |
| Synthesized explanation | `bx answers` | AI-generated, cites sources |
| Specific site search | `bx web` | Supports `site:` operators |
| Discussions/forums | `bx web --result-filter discussions` | Forums have solutions |
| Latest versions/releases | `bx context` or `bx news --freshness pd` | Fresh info |
| Security vulnerabilities | `bx context` or `bx news` | CVE details |
| Domain boosting/filtering | `--goggles` on context/web/news | Custom re-ranking |

**Default to `bx context`** — it replaces search + scrape + extract in one call.

## Usage Patterns

### Basic Search (context is default)

```bash
bx "your search query"
bx context "Python TypeError cannot unpack" --max-tokens 4096
```

### AI Answers

```bash
bx answers "explain Rust lifetimes" --no-stream | jq .
bx answers "compare SQLx vs Diesel" --enable-research
```

### Web Search

```bash
bx web "site:docs.rs axum middleware" --count 5
bx web "rust tutorial" --result-filter "web,discussions"
```

### News

```bash
bx news "npm security advisory" --freshness pd
bx news "kubernetes release" --freshness pw
```

### Images and Videos

```bash
bx images "system architecture diagram" | jq '.results[].thumbnail.src'
bx videos "rust async tutorial" | jq '.results[].url'
```

## Token Budget Control

```bash
bx context "topic" --max-tokens 4096 --max-tokens-per-url 1024 --max-urls 5
```

Use `--threshold strict` to filter low-relevance results.

## Domain Filtering

### Quick Include/Exclude

```bash
bx "rust axum" --include-site docs.rs --include-site github.com
bx web "tutorial" --exclude-site w3schools.com --exclude-site medium.com
```

### Goggles (Advanced Re-ranking)

Inline rules:

```bash
bx context "axum middleware" --goggles '$boost=5,site=docs.rs
$boost=3,site=github.com
/docs/$boost=5
/blog/$downrank=3
$discard,site=w3schools.com' --max-tokens 4096
```

From a file:

```bash
cat > /tmp/search.goggle << 'EOF'
$boost=5,site=docs.rs
$boost=3,site=github.com
$discard,site=w3schools.com
EOF
bx context "query" --goggles @/tmp/search.goggle
```

### Goggles DSL

| Rule | Effect |
|------|--------|
| `$boost=N,site=DOMAIN` | Promote domain (N=1-10) |
| `$downrank=N,site=DOMAIN` | Demote domain (N=1-10) |
| `$discard,site=DOMAIN` | Remove domain entirely |
| `/path/$boost=N` | Boost matching URL paths |
| `*pattern*$boost=N` | Wildcard URL matching |

## Freshness Filters

For `context`, `web`, `news`:

| Value | Meaning |
|-------|---------|
| `pd` | Past day |
| `pw` | Past week |
| `pm` | Past month |
| `py` | Past year |
| `YYYY-MM-DDtoYYYY-MM-DD` | Custom range |

```bash
bx news "topic" --freshness pd
bx context "topic" --freshness pw
```

## Response Shapes

### context (default)

```json
{
  "grounding": {
    "generic": [
      { "url": "...", "title": "...", "snippets": ["extracted content..."] }
    ]
  }
}
```

### answers --no-stream

```json
{"choices": [{"message": {"content": "..."}}]}
```

### web

```json
{
  "web": { "results": [{"title": "...", "url": "...", "description": "..."}] },
  "discussions": { "results": [...] }
}
```

## Exit Codes

| Code | Meaning | Action |
|------|---------|--------|
| 0 | Success | Process results |
| 1 | Client error | Fix query/params |
| 3 | Auth error (401/403) | Check API key: `bx config show-key` |
| 4 | Rate limited (429) | Retry after delay |
| 5 | Server/network error | Retry with backoff |

## Common Flags

| Flag | Commands | Description |
|------|----------|-------------|
| `--max-tokens N` | context | Total token budget |
| `--max-tokens-per-url N` | context | Per-URL token limit |
| `--max-urls N` | context | Max URLs to extract |
| `--threshold strict` | context | Filter low-relevance |
| `--count N` | web, news, images, videos | Number of results |
| `--freshness VALUE` | context, web, news | Time filter |
| `--goggles RULES` | context, web, news | Custom re-ranking |
| `--include-site DOMAIN` | context, web, news | Domain allowlist |
| `--exclude-site DOMAIN` | context, web, news | Domain blocklist |
| `--result-filter TYPES` | web | Filter result types |
| `--no-stream` | answers | Single JSON response |
| `--enable-research` | answers | Deep multi-step research |
| `--country CC` | all | Country code (default: US) |
| `--lang LANG` | all | Language (default: en) |

## Agent Workflow Examples

### Debugging an Error

```bash
bx "Python TypeError cannot unpack non-iterable NoneType" --max-tokens 4096
```

### Evaluating a Dependency

```bash
bx context "reqwest crate security issues maintained 2026" --threshold strict
bx news "reqwest Rust crate" --freshness pm
```

### Checking Breaking Changes

```bash
bx context "Next.js 15 breaking changes migration guide" --max-tokens 8192
```

### Corrective RAG Loop

```bash
# 1. Broad search
bx "axum middleware authentication" --max-tokens 4096
# 2. Too general? Narrow
bx "axum tower layer auth example" --threshold strict --max-tokens 4096
# 3. Need synthesis?
bx answers "how to implement JWT auth middleware in axum" --enable-research
```

## Setup

API key required. Get one at <https://api-dashboard.search.brave.com>. All plans include $5/month free credits (~1,000 queries).

```bash
bx config set-key    # interactive, avoids shell history
```

Priority: `--api-key` flag > `BRAVE_SEARCH_API_KEY` env var > `~/.config/brave-search/api_key` file.

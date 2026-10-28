/**
 * Glossary — inject industry-standard engineering definitions on demand.
 *
 * Reads the global glossary from the Pi agent dir (honors PI_CODING_AGENT_DIR)
 * and an optional project glossary:
 *   $PI_CODING_AGENT_DIR/glossary.json  (or .jsonl)
 *   <cwd>/.pi/glossary.json             (or .jsonl)  — overrides global by term
 *
 * When a prompt mentions a term (or alias), its definition is added to that
 * turn's context. Each term is injected once per session (and re-armed after
 * compaction). Definitions are sourced from ISO/IEC/IEEE 24765 (SEVOCAB).
 *
 * Attribution: definitions reproduced from SEVOCAB.
 *   Copyright ©, 2021, IEEE. Used by permission.
 *   ISO/IEC definitions are made publicly available; source is cited per term.
 *
 * Toggle/refresh with /glossary.
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { getAgentDir } from "@earendil-works/pi-coding-agent";
import { existsSync, readFileSync } from "node:fs";
import { join } from "node:path";

interface RawEntry {
  term: string;
  definition: string;
  aliases?: string[];
  pattern?: string;
  flags?: string;
  enabled?: boolean;
  source?: string;
}

interface CompiledEntry {
  term: string;
  definition: string;
  source?: string;
  matcher: RegExp;
}

function readEntries(path: string): RawEntry[] {
  if (!existsSync(path)) return [];
  let data: unknown;
  try {
    const text = readFileSync(path, "utf8");
    if (path.endsWith(".jsonl")) {
      data = text.split("\n").filter((l) => l.trim()).map((l) => JSON.parse(l));
    } else {
      data = JSON.parse(text);
    }
  } catch {
    return [];
  }
  const arr = Array.isArray(data)
    ? data
    : data && typeof data === "object" && Array.isArray((data as { entries?: unknown }).entries)
      ? (data as { entries: unknown[] }).entries
      : [];
  return arr.filter(
    (e): e is RawEntry =>
      !!e &&
      typeof (e as RawEntry).term === "string" &&
      typeof (e as RawEntry).definition === "string",
  );
}

function compile(entries: RawEntry[]): CompiledEntry[] {
  const byTerm = new Map<string, RawEntry>();
  for (const e of entries) {
    if (e.enabled === false) continue;
    byTerm.set(e.term.toLowerCase(), e); // project files load later and win
  }
  const out: CompiledEntry[] = [];
  for (const e of byTerm.values()) {
    const keys = [e.term, ...(e.aliases ?? [])].map((k) => k.trim()).filter(Boolean);
    if (keys.length === 0) continue;
    const escaped = keys.map((k) => k.replace(/[.*+?^${}()|[\]\\]/g, "\\$&"));
    const source = e.pattern ? e.pattern : `(?:${escaped.join("|")})`;
    let matcher: RegExp;
    try {
      matcher = new RegExp(`(?<![\\w-])(?:${source})(?![\\w-])`, e.flags ?? "iu");
    } catch {
      matcher = new RegExp(escaped[0], "iu");
    }
    out.push({ term: e.term, definition: e.definition, source: e.source, matcher });
  }
  return out;
}

export default function (pi: ExtensionAPI) {
  let entries: CompiledEntry[] = [];
  const injected = new Set<string>();
  let preambleDone = false;

  const load = (cwd: string) => {
    const agent = getAgentDir();
    const files = [
      join(agent, "glossary.json"),
      join(agent, "glossary.jsonl"),
      join(cwd, ".pi", "glossary.json"),
      join(cwd, ".pi", "glossary.jsonl"),
    ];
    const raw: RawEntry[] = [];
    for (const f of files) raw.push(...readEntries(f));
    entries = compile(raw);
    injected.clear();
    preambleDone = false;
  };

  pi.on("session_start", (_event, ctx) => load(ctx.cwd));
  pi.on("session_compact", () => {
    injected.clear();
    preambleDone = false;
  });

  pi.on("before_agent_start", (event) => {
    const prompt = event.prompt?.trim();
    if (!prompt || entries.length === 0) return;

    const matched = entries.filter((e) => !injected.has(e.term) && e.matcher.test(prompt));
    if (matched.length === 0) return;
    for (const e of matched) injected.add(e.term);

    const body = matched
      .map((e) => `### ${e.term}\n${e.definition}${e.source ? `\n_Source: ${e.source}_` : ""}`)
      .join("\n\n");

    const attribution =
      "Definitions from ISO/IEC/IEEE 24765 (SEVOCAB). Copyright ©, 2021, IEEE. Used by permission.";
    const header = preambleDone
      ? "## Engineering vocabulary"
      : `## Engineering vocabulary\nUse these terms with their standard meanings; do not invent synonyms for them. ${attribution}`;
    preambleDone = true;

    return {
      message: {
        customType: "glossary",
        content: `${header}\n\n${body}`,
        display: true,
        details: { terms: matched.map((e) => e.term) },
      },
    };
  });

  pi.registerCommand("glossary", {
    description: "Reload the engineering glossary and report how many terms are loaded",
    handler: (_arg, ctx) => {
      load(ctx.cwd);
      ctx.ui.notify(`glossary: ${entries.length} terms loaded from ${getAgentDir()}`, "info");
    },
  });
}

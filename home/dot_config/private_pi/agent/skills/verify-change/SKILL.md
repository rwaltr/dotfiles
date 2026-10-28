---
name: verify-change
description: Verification loop for any code or infrastructure change. Use before declaring work done — when to scout first, when to run a reviewer/oracle subagent, and what evidence to report. Applies across projects.
---

# Verify a change

Prefer a fresh set of eyes over an optimistic summary. Scale the loop to the change.

## Small, reversible edits (docs, one value)

1. Re-read the diff (`git diff`).
2. Run the relevant check: `mise run check` / `mise run lint`, `pre-commit run --all-files`,
   or the project's test command.
3. State exactly what you changed and what you did **not** test.

## Non-trivial changes (multi-file, behavioral, infra)

1. **Clarify** — restate the goal and the success condition before editing. If the scope
   is ambiguous, use the `ask_user_question` tool instead of guessing.
2. **Scout** — for anything spanning more than a couple of files, have `scout` map the
   relevant files, entry points, and risks first:
   `Use scout to find where <X> is configured and what depends on it.`
3. **Implement** — make the change in small, reviewable steps.
4. **Verify** — run the command that proves it works and capture the result. Test in the
   environment that matters (VM, staging, a throwaway clone), not just in the editor.
5. **Review** — run a `reviewer` against the diff, and an `oracle` second opinion when the
   decision itself is risky:
   `Use reviewer to review this diff against the task and the repo conventions.`
   `Ask oracle whether this plan has a failure mode we missed.`
6. **Report** — include the commands you ran and their outcome. Never claim a change
   works without evidence.

## Hard rules

- Do not say a change is "done" or "working" without a command/result that shows it. If you
  could not test it, say so explicitly.
- Never commit plaintext secrets. Use the `secrets-guard` extension where it is enabled, but
  do not rely on it as the only check.
- Keep one task per session where possible; branch with `/tree` instead of piling unrelated
  work into one transcript.
- Prefer `mise run` tasks over raw commands, and prefer OpenTofu (`tofu`) over Terraform when
  a project has migrated.

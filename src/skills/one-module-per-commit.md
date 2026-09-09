# One Module Per Commit

## Rule

**Never** create a git commit that modifies more than one Odoo addon directory.

Each commit must touch files under **exactly one** addon (e.g. only `boardkit_dashboard_crm/`, or only an addon under `odoo/custom/src/private/`).

This applies to work in this doodba project **and** in nested addon repos checked out under `odoo/custom/src/` (OCA clones, `odoo-boardkit`, etc.).

## Required behavior

- If a change set spans modules A and B, make **two commits** (A, then B).
- Identical mechanical fixes (EOF, lint, formatting) across addons still require **one commit per addon**.
- Commit header must use that addon's technical name: `[TAG] module_name: …`
- Do **not** use `various` to group multiple addons. Reserve `various` only for repo-root / non-addon paths (e.g. `.cursor/`, `devel.yaml`, `.pre-commit-config.yaml`).

## Examples

```text
# ❌ BAD — one commit, eight addons
[LINT] various: empty template addon __init__ files

# ✅ GOOD — eight commits
[LINT] boardkit_dashboard_crm: empty package __init__ file
[LINT] boardkit_dashboard_sale: empty package __init__ file
# …
```

```text
# ❌ BAD
[IMP] boardkit_dashboard, boardkit_dashboard_crm: add insert API and CRM tiles

# ✅ GOOD
[IMP] boardkit_dashboard: support insert ops and base-layout reflow
[ADD] boardkit_dashboard_crm: add CRM pipeline template
```

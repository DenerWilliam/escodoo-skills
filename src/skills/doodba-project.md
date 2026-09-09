# Doodba Project Context

This is a **Doodba** deployment (Odoo 18.0) scaffolded with doodba-copier-template v8.4.2, maintained by Escodoo.

## Directory structure

- `odoo/custom/src/private/` — Escodoo-owned addons; **this is where new code belongs**.
- `odoo/custom/src/<repo>/` — OCA and third-party clones governed by `repos.yaml`.  Do **not** edit these unless explicitly asked; they are overwritten by `gitaggregate`.
- `odoo/custom/src/addons.yaml` — maps repo names to installed addon lists.
- `odoo/custom/src/repos.yaml` — git-aggregator config (remotes, merges, PR refs).
- `odoo/auto/` — build-time artifacts; never edit or commit.

## Development environment

- Docker Compose with `devel.yaml` (and optionally `test.yaml`).
- Pre-commit is enabled; always run `pre-commit run --all-files` before pushing.
- Python target: 3.10+ (see `.ruff.toml`).
- Formatting: ruff-format + prettier (XML/JSON/YAML/MD).

## Coding guidelines

- Language: all code, comments, docstrings, and variable names in **English**.
- Match the style of surrounding code.  Reuse existing helpers and mixins.
- Never invent module paths — verify with `__manifest__.py` or `ls`.
- **One module per commit (mandatory)** — never change more than one Odoo addon in the same commit.
- Do **not** bump module `version` in `__manifest__.py` unless explicitly asked. On OCA repos, maintainers bump via `/ocabot merge patch|minor|major` at merge time.
- When creating or editing Escodoo addons, follow `odoo-oca-modules` (copyright placement, `readme/` fragments, manifest metadata, `hooks.py` / `__init__.py`).

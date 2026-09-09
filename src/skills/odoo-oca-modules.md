# Odoo / OCA Module Conventions (18.0)

Apply when creating or editing **Escodoo-owned** addons (`private/`, Escodoo repos such as `project-addons`). Do not bulk-edit OCA third-party clones unless explicitly asked.

## Module structure

Every addon must have a `__manifest__.py` at its root. Standard layout:

```
my_module/
  __init__.py
  __manifest__.py
  hooks.py         # post_init / uninstall / post_load hooks (when needed)
  readme/          # editable RST fragments (see README section)
  models/
  views/
  security/        # ir.model.access.csv, security.xml (groups, rules)
  data/            # non-demo data
  wizards/         # transient models
  reports/
  controllers/
  static/
  tests/
  i18n/
```

`README.rst` and `static/description/index.html` are **generated** — do not create them by hand.

## `__init__.py` and hooks

- Root `__init__.py` must contain **imports only** (subpackages + hook symbols). No business logic.
- Put `post_init_hook`, `uninstall_hook`, `pre_init_hook`, and `post_load` implementations in `hooks.py` (with copyright header).
- Re-export them from `__init__.py` so the manifest can reference the bare name:

```python
# __init__.py
from . import controllers
from . import models
from .hooks import uninstall_hook
```

```python
# hooks.py
# Copyright 2026 - TODAY, Nome Sobrenome <email@escodoo.com.br>
# License AGPL-3.0 or later (https://www.gnu.org/licenses/agpl).


def uninstall_hook(env):
    ...
```

```python
# __manifest__.py
"uninstall_hook": "uninstall_hook",
# or "post_init_hook": "post_init_hook", etc.
```

- Do **not** define hook functions inline in `__init__.py`.

## Copyright headers

### Where to put copyright (required)

- Models, wizards, reports, controllers, tests (`.py` with logic)
- Views and other business/UI XML

Python:

```python
# Copyright 2026 - TODAY, Nome Sobrenome <email@escodoo.com.br>
# License AGPL-3.0 or later (https://www.gnu.org/licenses/agpl).
```

XML (immediately after `<?xml version="1.0" encoding="utf-8" ?>`):

```xml
<!-- Copyright 2026 - TODAY, Nome Sobrenome <email@escodoo.com.br>
     License AGPL-3.0 or later (https://www.gnu.org/licenses/agpl). -->
```

`__manifest__.py` uses the **company** copyright:

```python
# Copyright 2026 Escodoo
# License AGPL-3.0 or later (https://www.gnu.org/licenses/agpl).
```

### Where NOT to put copyright

- `__init__.py` (root, `models/`, `tests/`, etc.) — imports only
- `security/*.xml` and `data/*.xml` (groups, tier definitions, config data)
- `readme/*.rst`, generated `README.rst`, `static/description/index.html`

### Anti-patterns

- Do not stamp `# Copyright YEAR Escodoo` on every file.
- Do not add copyright headers to `__init__.py`, security, or data XML.

## README / documentation

Edit **only** fragments under `readme/`:

| File | Role |
|------|------|
| `DESCRIPTION.rst` | Required — module purpose |
| `USAGE.rst` | How to use |
| `CONFIGURE.rst` / `INSTALL.rst` | As needed |
| `CONTRIBUTORS.rst` | Escodoo → person (see existing modules) |

- **Do not** hand-write or edit `README.rst` or `static/description/index.html`. They are produced by `oca-gen-addon-readme` (pre-commit in this doodba project targets `private/`; Escodoo repos like `project-addons` have their own hook).
- **Do not** run `oca-gen-addon-readme` unless the user explicitly asks. Pre-commit regenerates when fragments change.
- Write generic product docs in **English**. No customer go-live checklists, client-specific external systems, or internal backlog in the public README.

## `__manifest__.py`

- `version`: format `18.0.X.Y.Z` (three-segment after the Odoo series) when creating a **new** module. Do **not** bump `version` in existing modules unless the user explicitly asks.
- **OCA modules:** never change `version` in the PR. Version bumps are done at merge time by **ocabot** when a maintainer comments `/ocabot merge patch`, `/ocabot merge minor`, or `/ocabot merge major`. Suggest the appropriate bump level in the PR description if useful; do not edit the manifest yourself.
- **Migration scripts:** if a `migrations/<version>/` folder is needed, name it for the **expected post-ocabot version** (e.g. current `18.0.1.3.2` + minor → `migrations/18.0.1.4.0/`), still without editing `__manifest__.py`.
- `author`: `"Escodoo"`.
- `website`: specific repository URL (e.g. `https://github.com/Escodoo/project-addons`), not only `https://github.com/Escodoo`.
- `license`: `"AGPL-3"` for Escodoo/OCA addons (`LGPL-3` / `BSL-1.0` only per explicit project policy).
- `development_status`: e.g. `"Beta"`.
- `maintainers`: GitHub username(s), e.g. `["marcelsavegnago"]`.
- List all direct dependencies in `depends` — never rely on transitive installs.
- Keep `external_dependencies` accurate (Python libs, system bins).

## XML / views

- Inherit views using `<xpath>` with precise `expr` selectors.
- Use `<field name="inherit_id" ref="module.view_xml_id"/>` — never hard-code database IDs.
- Record `xml_id` format: `<module>.<model>_<purpose>`, e.g. `my_module.view_res_partner_form`.

## Python

- Import order enforced by ruff/isort: stdlib → third-party → `odoo` → `odoo.addons` → local.
- Use `odoo.exceptions` (`UserError`, `ValidationError`) for user-facing errors.
- Prefer `@api.depends` / `@api.constrains` decorators over manual recomputation.
- Security: add `ir.model.access.csv` rows for every new model; add record rules as needed.

## Testing

- Place tests in `tests/` with `__init__.py` importing each test module.
- Use `TransactionCase` or `SavepointCase`; tag slow tests with `@tagged('post_install', '-at_install')`.

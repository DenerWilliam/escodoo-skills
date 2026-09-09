# Commit Message Rules (Odoo R&D Style)

## Header format

```
[TAG] module_name: short description (< 50 chars ideal)
```

The header must form a valid sentence when prepended with *"if applied, this commit will …"*.

## Allowed tags

| Tag | When to use |
|-----|-------------|
| `[FIX]` | Bug fix (stable or recent dev bug) |
| `[IMP]` | Incremental improvement |
| `[ADD]` | New module or major new feature |
| `[REF]` | Heavy refactoring of existing feature |
| `[REM]` | Removing dead code, views, or modules |
| `[REV]` | Reverting a previous commit |
| `[MOV]` | Moving files (use `git mv`; don't change content in the same commit) |
| `[REL]` | Release commit (new stable version) |
| `[MERGE]` | Merge / forward-port commit |
| `[I18N]` | Translation file changes |
| `[PERF]` | Performance optimization |
| `[CLN]` | Code cleanup |
| `[LINT]` | Linting pass |

## Module name

- Use the **technical** module name (e.g. `sale_order_type`, not "Sale Order Type").

## One module per commit (mandatory)

- **Never** put changes to more than one Odoo addon in the same commit.
- If work touches modules A and B, create **two commits** (A, then B) — even for identical lint/EOF/whitespace fixes.
- The header module name must match the single addon directory changed.
- Use `various` **only** for repository-level non-addon files (e.g. root CI, `.pre-commit-config.yaml`, shared docs outside any addon). Never use `various` to bundle multiple addons.

## Body

1. Leave one blank line after the header.
2. Explain **WHY** the change is made — the purpose, business requirement, or bug root cause.
3. Only explain **WHAT** if there are non-obvious technical decisions.
4. End with references when applicable:

```
task-123
Fixes #456
Closes #789
opw-012
```

## Examples

```
[IMP] sale_order_type: add default warehouse per order type

Customers with multiple warehouses need orders to auto-select the
correct warehouse based on the chosen order type, reducing manual
errors during order entry.

task-4521
```

```
[FIX] account_move_line: prevent duplicate analytic entries on reversal

When reversing an invoice that has analytic lines, the reversal
duplicated analytic entries because _prepare_analytic_lines was
called before the sign flip.  Now we skip analytic generation for
reversal moves and let the original entries be negated instead.

Fixes #1782
```

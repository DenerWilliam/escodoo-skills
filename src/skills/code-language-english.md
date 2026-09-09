# Code Language: English Only

All **source code** in this repository must be written in **English**. Chat with humans may be in Portuguese; code must not.

## Must be English

- Identifiers: modules, models, fields, methods, variables, XML IDs, CSS classes
- Comments, docstrings, and log/error messages
- Commit messages (Odoo R&D style)
- User-visible **source** strings: view labels, button strings, help texts, wizard titles, spreadsheet dashboard titles/KPIs/chart names, README fragments, `__manifest__.py` `name`/`summary`/`description`
- Demo data labels and selection option labels in Python/XML

## Must not

- Hardcode Portuguese (or any non-English language) in source files "because the UI is pt_BR"
- Mix languages in the same string set (e.g. English KPIs + Portuguese ranking titles)

## Translations

- Keep English as the source language.
- Add Portuguese (and other locales) via `i18n/*.po` / export-import — never by replacing English in code.
- Prefer `_()` / `_t()` (or equivalent) for translatable strings when the framework supports it.

## Examples

```python
# ❌ BAD
title = "Tickets Abertos por Time"
help = "Filtra chamados em andamento"

# ✅ GOOD
title = "Open Tickets by Team"
help = "Filter tickets in progress"
```

```json
// ❌ BAD — spreadsheet JSON
"text": "Chamados em Andamento"

// ✅ GOOD
"text": "In Progress"
```

If the user asks for Portuguese wording, interpret it as the **meaning**, implement the English source string, and use i18n for pt_BR when translations are in scope.

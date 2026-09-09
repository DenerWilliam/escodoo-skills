# @escodoo/skills

> Shared development conventions and rules for Odoo/Doodba projects — ready for Opencode, Claude Code, and Cursor.

## What is this?

A multi-platform skill library that installs development conventions for different AI coding assistants. Instead of maintaining separate rule sets for each AI, you write the content once and the CLI converts it to the right format.

## Supported AIs

| AI | Format | Directory |
|----|--------|-----------|
| [Opencode](https://opencode.ai) | `SKILL.md` | `.opencode/skills/` |
| [Claude Code](https://claude.ai/code) | `.md` command | `.claude/commands/` |
| [Cursor](https://cursor.com) | `.mdc` rule | `.cursor/rules/` |

## Available Skills

- **commit-messages** — Odoo R&D commit message format (tags, scope, WHY-first body)
- **doodba-project** — Doodba 18.0 project layout, workflow, and conventions
- **code-language-english** — All source code must be in English
- **odoo-oca-modules** — Escodoo/OCA module structure, copyright, README, manifest, hooks
- **one-module-per-commit** — One Odoo addon per git commit (mandatory)

## Quick Start

### Install

```bash
curl -fsSL https://raw.githubusercontent.com/DenerWilliam/escodoo-skills/main/install.sh | bash
```

After install, restart your terminal or run:
```bash
source ~/.bashrc
```

### Use

```bash
escodoo-skills opencode    # Opencode only
escodoo-skills claude      # Claude Code only
escodoo-skills cursor      # Cursor only
escodoo-skills all         # All AIs
```

Or install in a specific directory:
```bash
escodoo-skills all ./my-odoo-project
```

### Update

Just run the install script again — it will update automatically:

```bash
curl -fsSL https://raw.githubusercontent.com/DenerWilliam/escodoo-skills/main/install.sh | bash
```

### Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/DenerWilliam/escodoo-skills/main/uninstall.sh | bash
```

## Development

```bash
# Clone the repo
git clone https://github.com/DenerWilliam/escodoo-skills.git
cd escodoo-skills

# Install dependencies
npm install

# Build
npm run build

# Test the CLI locally
escodoo-skills all ./test-project
```

## Project Structure

```
escodoo-skills/
├── src/
│   ├── skills/           # Markdown content (source of truth)
│   │   ├── commit-messages.md
│   │   ├── doodba-project.md
│   │   └── ...
│   ├── converters/       # Format converters
│   │   └── opencode.ts   # (opencode, claude, cursor)
│   ├── cli.ts           # CLI entry point
│   └── index.ts
├── bin/                 # CLI launcher
├── install.sh           # Installation script
├── uninstall.sh         # Uninstallation script
└── package.json
```

## Adding New Skills

See [SKILLS_GUIDE.md](SKILLS_GUIDE.md) for a detailed guide on how to create and test new skills.

Quick summary:

1. Create a new `.md` file in `src/skills/` following the template
2. Run `npm run build`
3. Test with `escodoo-skills all ./test-project`
4. Open a PR

No frontmatter is needed in source files — frontmatter is generated during conversion.

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT — see [LICENSE](LICENSE) for details.

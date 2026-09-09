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

```bash
# Install from GitHub
npm install github:escodoo/skills

# Install skills in current directory
escodoo-skills opencode    # Opencode only
escodoo-skills claude      # Claude Code only
escodoo-skills cursor      # Cursor only
escodoo-skills all         # All AIs
```

Or use a specific target directory:

```bash
escodoo-skills all ./my-odoo-project
```

### Alternative Install Methods

```bash
# Full git URL
npm install git+https://github.com/escodoo/skills.git

# With specific version/tag
npm install github:escodoo/skills#v1.0.0

# After npm publish: install globally via npm
npm install -g @escodoo/skills
```

## Development

```bash
# Clone the repo
git clone https://github.com/escodoo/skills.git
cd skills

# Install dependencies
npm install

# Build
npm run build

# Test the CLI locally
npm link
escodoo-skills all ./test-project
```

## Project Structure

```
@escodoo/skills/
├── src/
│   ├── skills/           # Markdown content (source of truth)
│   │   ├── commit-messages.md
│   │   ├── doodba-project.md
│   │   └── ...
│   ├── converters/       # Format converters
│   │   ├── opencode.ts
│   │   ├── claude.ts
│   │   └── cursor.ts
│   ├── cli.ts           # CLI entry point
│   └── index.ts
├── package.json
├── tsup.config.ts
└── tsconfig.json
```

## Adding New Skills

See [SKILLS_GUIDE.md](SKILLS_GUIDE.md) for a detailed guide on how to create and test new skills.

Quick summary:

1. Create a new `.md` file in `src/skills/` following the template
2. Run `npm run build`
3. Test with `escodoo-skills all ./test-project`
4. Open a PR

No frontmatter is needed in source files — frontmatter is generated during conversion.

## Publishing

```bash
npm run build
npm version patch|minor|major
npm publish --access public
```

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT — see [LICENSE](LICENSE) for details.

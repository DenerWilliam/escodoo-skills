# Contributing to @escodoo/skills

Thank you for your interest in contributing!

## How to Contribute

### Reporting Issues

- Check if the issue already exists before creating a new one
- Use a clear, descriptive title
- Include the AI tool you're using, the skill affected, and the expected vs actual behavior

### Suggesting New Skills

- Open an issue with the label "enhancement"
- Describe the skill and when it should be applied
- Provide examples of the content

### Submitting Changes

1. **Fork the repository**
2. **Create a feature branch:**
   ```bash
   git checkout -b skill/my-new-skill
   # or
   git checkout -b fix/correct-commit-format
   ```
3. **Make your changes** — edit files in `src/skills/` (content) or `src/converters/` (code)
4. **Test your changes:**
   ```bash
   npm install
   npm run build
   npm link
   escodoo-skills all ./test-project
   # Verify the output in test-project/
   ```
5. **Commit** using the same commit message format (we follow Odoo R&D style):
   ```text
   [ADD] skill-name: short description
   [IMP] converter-name: improvement description
   [FIX] skill-name: fix description
   ```
6. **Open a Pull Request**

## Project Structure

```
src/
├── skills/           # Markdown source files (edit these for content)
│   └── *.md
├── converters/       # AI-specific format converters
│   ├── opencode.ts
│   ├── claude.ts
│   └── cursor.ts
└── cli.ts           # CLI entry point
```

## Adding a New Skill

See [SKILLS_GUIDE.md](SKILLS_GUIDE.md) for a detailed template and examples.

Quick steps:
1. Create `src/skills/your-skill-name.md` using the template
2. Rebuild: `npm run build`
3. Test: `escodoo-skills all ./test-project`

## Adding a New AI Converter

1. Create `src/converters/your-ai.ts`
2. Export a function: `export function installYourAI(targetDir: string, skills: Skill[]): void`
3. Import and add to `cli.ts`
4. Update README with the new AI

## Code Style

- TypeScript with strict mode
- Use ESM imports
- No unnecessary dependencies

## Questions?

Open an issue or reach out to the maintainers.

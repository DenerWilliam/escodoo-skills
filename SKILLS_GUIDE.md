# Creating New Skills

This guide explains how to add new skills to `@escodoo/skills`.

## Quick Steps

1. Create a new `.md` file in `src/skills/`
2. Follow the template structure (see below)
3. Rebuild: `npm run build`
4. Test: `escodoo-skills all ./test-project`
5. Open a PR

## File Naming

- Use **kebab-case**: `my-new-skill.md`
- Match the filename to the skill name
- No spaces or special characters

## Content Structure

Every skill should follow this structure:

```markdown
# Skill Title

Describe what this skill does and **when** it should be used.
Be specific about triggers and scenarios.

## Rule

The main guideline or rule. Be clear and concise.

## Examples

Show both ✅ Good and ❌ Bad examples when applicable.

### ✅ Good

```text
Example of correct behavior
```

### ❌ Bad

```text
Example of incorrect behavior
```

## Related Skills

- `other-skill` - How it relates
```

## Writing Tips

### Do

- Start with a clear level-1 heading (# Title)
- Describe **when** to use the skill in the intro
- Use code blocks for examples
- Be specific, not generic
- Include ✅/❌ examples for rules
- Reference related skills when applicable

### Don't

- Don't add frontmatter (it's auto-generated)
- Don't use complex markdown that won't render in all AIs
- Don't make the description too vague
- Don't duplicate existing skills

## Testing Your Skill

```bash
# Build the project
npm run build

# Test installation in a clean directory
mkdir /tmp/test-new-skill
escodoo-skills all /tmp/test-new-skill

# Verify the output
cat /tmp/test-new-skill/.opencode/skills/your-skill/SKILL.md
cat /tmp/test-new-skill/.claude/commands/your-skill.md
cat /tmp/test-new-skill/.cursor/rules/your-skill.mdc
```

## Example: Adding a "Tests" Skill

1. Create `src/skills/odoo-tests.md`:

```markdown
# Odoo Testing Guidelines

Use when writing or reviewing tests for Odoo modules.

## Rule

All tests must be in the `tests/` directory with proper structure.

## Examples

### ✅ Good

```python
class TestSaleOrder(TransactionCase):
    def test_confirm_order(self):
        order = self.env['sale.order'].create({...})
        order.action_confirm()
        self.assertEqual(order.state, 'sale')
```

### ❌ Bad

```python
# Tests in the same file as models
class SaleOrder(models.Model):
    def test_something(self):
        ...
```

## Related Skills

- `odoo-oca-modules` - Module structure
- `commit-messages` - Commit format for tests
```

2. Build and test:
```bash
npm run build
escodoo-skills all ./test-project
```

3. Check that the skill was converted correctly in all 3 formats.

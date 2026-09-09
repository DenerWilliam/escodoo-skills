import { readFileSync, mkdirSync, writeFileSync, existsSync, readdirSync } from "fs";
import { join, dirname } from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const SKILLS_DIR = join(__dirname, "..", "src", "skills");

export interface Skill {
  name: string;
  description: string;
  content: string;
}

export function getSkills(): Skill[] {
  const files = readdirSync(SKILLS_DIR).filter((f) => f.endsWith(".md"));
  return files.map((file) => {
    const name = file.replace(".md", "");
    const content = readFileSync(join(SKILLS_DIR, file), "utf-8");
    const descriptionMatch = content.match(/^#\s+(.+)/);
    const description = descriptionMatch ? descriptionMatch[1] : name;
    return { name, description, content };
  });
}

export function installOpencode(targetDir: string): void {
  const skills = getSkills();
  const outputDir = join(targetDir, ".opencode", "skills");

  mkdirSync(outputDir, { recursive: true });

  skills.forEach((skill) => {
    const skillDir = join(outputDir, skill.name);
    mkdirSync(skillDir, { recursive: true });

    const frontmatter = `---
name: ${skill.name}
description: ${skill.description}
---

`;
    writeFileSync(join(skillDir, "SKILL.md"), frontmatter + skill.content);
  });

  const opencodeConfig = {
    $schema: "https://opencode.ai/config.json",
    skills: {
      paths: [".opencode/skills"],
    },
  };

  const configPath = join(targetDir, "opencode.json");
  if (!existsSync(configPath)) {
    writeFileSync(configPath, JSON.stringify(opencodeConfig, null, 2) + "\n");
  }
}

export function installClaude(targetDir: string, skills: Skill[]): void {
  const outputDir = join(targetDir, ".claude", "commands");

  mkdirSync(outputDir, { recursive: true });

  skills.forEach((skill) => {
    const frontmatter = `---
description: ${skill.description}
---

# ${skill.content}
`;
    writeFileSync(join(outputDir, `${skill.name}.md`), frontmatter);
  });
}

export function installCursor(targetDir: string, skills: Skill[]): void {
  const outputDir = join(targetDir, ".cursor", "rules");

  mkdirSync(outputDir, { recursive: true });

  skills.forEach((skill) => {
    const frontmatter = `---
description: ${skill.description}
alwaysApply: true
---

# ${skill.content}
`;
    writeFileSync(join(outputDir, `${skill.name}.mdc`), frontmatter);
  });
}

import { mkdirSync, writeFileSync } from "fs";
import { join } from "path";

interface Skill {
  name: string;
  description: string;
  content: string;
}

export function installClaude(targetDir: string, skills: Skill[]): void {
  const outputDir = join(targetDir, ".claude", "commands");

  mkdirSync(outputDir, { recursive: true });

  skills.forEach((skill) => {
    const frontmatter = `---
description: ${skill.description}
---

`;
    writeFileSync(join(outputDir, `${skill.name}.md`), frontmatter + "# " + skill.content);
  });
}

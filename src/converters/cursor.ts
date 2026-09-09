import { mkdirSync, writeFileSync } from "fs";
import { join } from "path";

interface Skill {
  name: string;
  description: string;
  content: string;
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

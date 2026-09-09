#!/usr/bin/env node

import chalk from "chalk";
import { installOpencode, getSkills } from "./converters/opencode.js";
import { installClaude } from "./converters/claude.js";
import { installCursor } from "./converters/cursor.js";
import { join } from "path";

const SKILLS = getSkills();

function showHelp() {
  console.log(`
${chalk.cyan("🔧 Escodoo Skills Installer")}

${chalk.yellow("Usage:")}
  escodoo-skills <ai> [target-dir]

${chalk.yellow("AIs:")}
  opencode   - Install skills for Opencode
  claude     - Install skills for Claude Code
  cursor     - Install skills for Cursor
  all        - Install for all AIs

${chalk.yellow("Examples:")}
  escodoo-skills opencode
  escodoo-skills claude ./my-project
  escodoo-skills all

${chalk.yellow("Skills available:")}
${SKILLS.map((s) => `  - ${chalk.blue(s.name)}: ${s.description}`).join("\n")}
`);
}

async function main() {
  const args = process.argv.slice(2);

  if (args.includes("--help") || args.includes("-h") || args.length === 0) {
    showHelp();
    return;
  }

  const ai = args[0]?.toLowerCase();
  const targetDir = args[1] || process.cwd();

  if (!["opencode", "claude", "cursor", "all"].includes(ai)) {
    console.error(chalk.red(`\n❌ Unknown AI: "${ai}"\n`));
    showHelp();
    process.exit(1);
  }

  console.log(chalk.cyan(`\n🔧 Installing skills for ${chalk.bold(ai)} in ${chalk.dim(targetDir)}\n`));

  const skillsInfo = SKILLS.map((s) => `  - ${s.name}: ${s.description}`).join("\n");
  console.log(chalk.blue(`Skills:\n${skillsInfo}\n`));

  try {
    if (ai === "opencode" || ai === "all") {
      installOpencode(targetDir);
      console.log(chalk.green("✅ Opencode skills installed!"));
    }

    if (ai === "claude" || ai === "all") {
      installClaude(targetDir, SKILLS);
      console.log(chalk.green("✅ Claude Code skills installed!"));
    }

    if (ai === "cursor" || ai === "all") {
      installCursor(targetDir, SKILLS);
      console.log(chalk.green("✅ Cursor skills installed!"));
    }

    console.log(chalk.cyan("\n✨ Installation complete!\n"));
  } catch (error) {
    console.error(chalk.red("\n❌ Error during installation:"), error);
    process.exit(1);
  }
}

main();

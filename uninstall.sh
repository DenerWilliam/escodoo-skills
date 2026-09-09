#!/bin/bash

set -e

INSTALL_DIR="$HOME/.escodoo-skills"
BIN_DIR="$HOME/.local/bin"
PROFILE_FILE="$HOME/.bashrc"

echo "🗑️  Uninstalling @escodoo/skills..."

# Remove installation directory
if [ -d "$INSTALL_DIR" ]; then
    rm -rf "$INSTALL_DIR"
    echo "✅ Removed $INSTALL_DIR"
else
    echo "ℹ️  Installation directory not found"
fi

# Remove launcher
if [ -f "$BIN_DIR/escodoo-skills" ]; then
    rm "$BIN_DIR/escodoo-skills"
    echo "✅ Removed $BIN_DIR/escodoo-skills"
fi

# Remove PATH from shell config
if [ -f "$PROFILE_FILE" ]; then
    if grep -q "# escodoo-skills" "$PROFILE_FILE"; then
        sed -i '/# escodoo-skills/d' "$PROFILE_FILE"
        sed -i '/export PATH="\$HOME\/\.local\/bin:\$PATH"/d' "$PROFILE_FILE"
        echo "✅ Removed PATH from $PROFILE_FILE"
    fi
fi

echo ""
echo "✅ Uninstallation complete!"
echo ""
echo "Note: You may need to restart your terminal or run:"
echo "  source ~/.bashrc"

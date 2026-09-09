#!/bin/bash

set -e

INSTALL_DIR="$HOME/.escodoo-skills"
BIN_DIR="$HOME/.local/bin"
PROFILE_FILE="$HOME/.bashrc"

echo "🔧 Installing @escodoo/skills..."

# Clone or update the repo
if [ -d "$INSTALL_DIR/.git" ]; then
    echo "📦 Updating existing installation..."
    cd "$INSTALL_DIR"
    git pull origin main
else
    echo "📦 Cloning repository..."
    git clone https://github.com/DenerWilliam/escodoo-skills.git "$INSTALL_DIR"
    cd "$INSTALL_DIR"
fi

# Install dependencies and build
echo "📦 Installing dependencies..."
npm install
echo "📦 Building..."
npm run build

# Create bin directory in PATH
mkdir -p "$BIN_DIR"

# Create a launcher script in bin
cat > "$BIN_DIR/escodoo-skills" << 'EOF'
#!/bin/sh
exec node "$HOME/.escodoo-skills/dist/cli.js" "$@"
EOF

chmod +x "$BIN_DIR/escodoo-skills"
echo "✅ Created launcher in $BIN_DIR"

# Add to PATH if not already added
if [ -f "$PROFILE_FILE" ]; then
    MARKER="# escodoo-skills"
    PATH_LINE="export PATH=\"$BIN_DIR:\$PATH\""

    if ! grep -q "$MARKER" "$PROFILE_FILE"; then
        echo "" >> "$PROFILE_FILE"
        echo "$MARKER" >> "$PROFILE_FILE"
        echo "$PATH_LINE" >> "$PROFILE_FILE"
        echo "✅ Added PATH to $PROFILE_FILE"
    else
        echo "✅ PATH already configured"
    fi
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "To use, run:"
echo "  source $PROFILE_FILE"
echo "  escodoo-skills opencode"
echo ""
echo "To update later, just run this script again:"
echo "  curl -fsSL https://raw.githubusercontent.com/DenerWilliam/escodoo-skills/main/install.sh | bash"
echo ""
echo "To uninstall:"
echo "  curl -fsSL https://raw.githubusercontent.com/DenerWilliam/escodoo-skills/main/uninstall.sh | bash"

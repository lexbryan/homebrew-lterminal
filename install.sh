#!/usr/bin/env bash
#
# Install lterminal by symlinking it onto your PATH.
#   ./install.sh            # links into ~/bin (or first writable dir on PATH)
#   ./install.sh /usr/local/bin
#
set -euo pipefail

DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
SRC="$DIR/bin/lterminal"

TARGET_DIR="${1:-$HOME/bin}"
mkdir -p "$TARGET_DIR"

chmod +x "$SRC"
ln -sf "$SRC" "$TARGET_DIR/lterminal"
echo "Linked $TARGET_DIR/lterminal -> $SRC"

case ":$PATH:" in
  *":$TARGET_DIR:"*) ;;
  *) echo "Note: $TARGET_DIR is not on your PATH."
     echo "      Add this to your shell profile:  export PATH=\"$TARGET_DIR:\$PATH\"" ;;
esac

echo "Try:  lterminal snap --dry-run"

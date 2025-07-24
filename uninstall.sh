#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

remove_aliases() {
    log_info "Removing git aliases..."
    git config --global --unset alias.ap 2>/dev/null || true
    git config --global --unset alias.aliases 2>/dev/null || true
    git config --global --unset alias.whereami 2>/dev/null || true
    git config --global --unset alias.which 2>/dev/null || true
    git config --global --unset alias.cob 2>/dev/null || true
    git config --global --unset alias.coma 2>/dev/null || true
    git config --global --unset alias.empty 2>/dev/null || true
    git config --global --unset alias.l1 2>/dev/null || true
    git config --global --unset alias.log1 2>/dev/null || true
    git config --global --unset alias.ll 2>/dev/null || true
    git config --global --unset alias.s 2>/dev/null || true
    git config --global --unset alias.sp 2>/dev/null || true
    git config --global --unset alias.scratch 2>/dev/null || true
    # Remove old alias if it exists
    git config --global --unset alias.new 2>/dev/null || true
}

remove_path() {
    log_warn "Please manually remove the PATH entry from your shell config file"
    echo "Look for and remove: export PATH=\"$SCRIPT_DIR/bin:\$PATH\""
    
    case "$SHELL" in
        */zsh) echo "Check: $HOME/.zshrc" ;;
        */bash) echo "Check: $HOME/.bashrc" ;;
        *) echo "Check: $HOME/.profile" ;;
    esac
}

main() {
    echo -n "Are you sure you want to uninstall Git-Aliases? (y/N): "
    read -r confirm
    [[ ! "$confirm" =~ ^[Yy]$ ]] && exit 0
    
    remove_aliases
    remove_path
    rm -f "$SCRIPT_DIR/version.txt"
    
    log_info "Git-Aliases uninstalled"
    log_info "Custom git commands in bin/ are still available if PATH entry remains"
}

main "$@"

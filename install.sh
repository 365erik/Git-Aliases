#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION_FILE="$SCRIPT_DIR/version.txt"
CURRENT_VERSION="1.0.0"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

check_dependencies() {
    log_info "Checking dependencies..."
    command -v git >/dev/null 2>&1 || { log_error "Git is required but not installed."; exit 1; }
}

check_version() {
    if [ -f "$VERSION_FILE" ]; then
        INSTALLED_VERSION=$(cat "$VERSION_FILE")
        if [ "$INSTALLED_VERSION" = "$CURRENT_VERSION" ]; then
            log_warn "Git-Aliases $CURRENT_VERSION is already installed."
            echo -n "Reinstall? (y/N): "
            read -r reinstall
            [[ ! "$reinstall" =~ ^[Yy]$ ]] && exit 0
        else
            log_info "Upgrading from $INSTALLED_VERSION to $CURRENT_VERSION"
        fi
    fi
}

install_aliases() {
    log_info "Installing git aliases..."
    "$SCRIPT_DIR/scripts/install-aliases.sh"
}

install_bin_commands() {
    log_info "Installing custom git commands..."
    "$SCRIPT_DIR/scripts/install-bin.sh"
}

setup_user_config() {
    log_info "Checking user configuration..."
    
    # Check if githubusername is set
    if ! git config user.githubusername >/dev/null 2>&1; then
        log_warn "user.githubusername is not set."
        echo -n "Enter your GitHub username: "
        read -r github_username
        if [ -n "$github_username" ]; then
            git config --global user.githubusername "$github_username"
            log_info "Set user.githubusername to '$github_username'"
        fi
    fi
}

setup_path() {
    BIN_DIR="$SCRIPT_DIR/bin"
    SHELL_RC=""
    
    case "$SHELL" in
        */zsh) SHELL_RC="$HOME/.zshrc" ;;
        */bash) SHELL_RC="$HOME/.bashrc" ;;
        *) SHELL_RC="$HOME/.profile" ;;
    esac
    
    if ! echo "$PATH" | grep -q "$BIN_DIR"; then
        log_info "Adding $BIN_DIR to PATH in $SHELL_RC"
        echo "" >> "$SHELL_RC"
        echo "# Git-Aliases custom commands" >> "$SHELL_RC"
        echo "export PATH=\"$BIN_DIR:\$PATH\"" >> "$SHELL_RC"
        log_info "Please run: source $SHELL_RC"
    else
        log_info "PATH already contains $BIN_DIR"
    fi
}

main() {
    log_info "Installing Git-Aliases v$CURRENT_VERSION..."
    
    check_dependencies
    check_version
    install_aliases
    install_bin_commands
    setup_user_config
    setup_path
    
    # Save version
    echo "$CURRENT_VERSION" > "$VERSION_FILE"
    
    log_info "Installation complete!"
    log_info "Available commands:"
    echo "  - git new-branch (interactive branch creator)"
    echo "  - git aliases (list all aliases)"
    echo "  - git s (status)"
    echo "  - git ll (log with graph)"
    echo "  - And more..."
}

main "$@"

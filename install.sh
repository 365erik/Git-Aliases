git config --global alias.log1 'log --oneline'
git config --global alias.l1 'log --oneline'
git config --global alias.ll 'log --oneline --graph --all --decorate'
# list all aliases
git config --global alias.aliases 'config --get-regexp ^alias'
# Checkout -b
git config --global alias.cob 'checkout -b'
# Commit all changes with message
git config --global alias.coma 'commit -am'
# Make an empty commit
git config --global alias.empty 'commit --allow-empty -m'
# Show current branch
git config --global alias.whereami 'branch --show-current'
# Add -p
git config --global alias.ap 'add -p'
# status
git config --global alias.s 'status'
git config --global alias.sp 'status --porcelain'
# new
git config --global alias.new "!f() { git checkout main && git pull origin main && git checkout -b \"\$1\" && git commit --allow-empty -m \"First commit on \$1\"; }; f"
# scratch
git config --global alias.scratch "!f() { echo \"Hello, World\"; }; f"

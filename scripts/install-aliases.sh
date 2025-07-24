#!/bin/bash
# Git aliases installation script

# add -p
git config --global alias.ap 'add -p'

# aliases
## list all
git config --global alias.aliases 'config --get-regexp ^alias'

# branch
## current branch
git config --global alias.whereami 'branch --show-current'
git config --global alias.which 'branch --show-current'

# checkout -b
git config --global alias.cob 'checkout -b'

# commit
## commit all changes with message
git config --global alias.coma 'commit -am'
## Make an empty commit
git config --global alias.empty 'commit --allow-empty -m'

# log
git config --global alias.l1 'log --oneline'
git config --global alias.log1 'log --oneline'
## show with graph
git config --global alias.ll 'log --oneline --graph --all --decorate'

# status
git config --global alias.s 'status'
git config --global alias.sp 'status --porcelain'

# functions
## scratch
git config --global alias.scratch "!f() { echo \"Hello, World\"; }; f"

echo "Git aliases installed successfully!"

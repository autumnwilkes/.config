export PATH="/home/ubuntu/.bun/bin:/opt/nvim-linux-x86_64/bin:$PATH"

# File System Aliases
alias ll="eza -al"
alias ls="ls -la"
alias th="cd"
alias nd="mkdir"

# Git Aliases
alias c="git commit -a"
alias push="git push"
alias pull="git pull"
alias fetch="git fetch"
alias checkout="git checkout"
alias rust="-R rust-lang/rust"
alias ubuntu="cd /home/ubuntu"
alias scout="cd /home/ubuntu/chaotic-chickens/" # Rember to update!

# Neovim Aliases
alias e="nvim"

GPG_TTY=$(tty)
export GPG_TTY

eval "$(starship init zsh)"

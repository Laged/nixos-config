# Aliases
alias ls="eza"
alias ll="eza --long"
alias lt="eza --long --tree --all"
alias ltf="eza --long --tree --level=3"
alias cat="bat"
alias a="bat -A"
alias b="batdiff"
alias bs="batdiff --staged"
alias c="clear"
alias ga="git add -A"
alias gs="git status"
alias kc="nix-build '<nixpkgs/nixos>' \
    --arg configuration ./configuration.nix --attr config.system.build.kexecTree"

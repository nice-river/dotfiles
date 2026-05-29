if status is-interactive
# Commands to run in interactive sessions can go here
end

alias ls='eza -lh --icons'
alias ll='eza -lh --icons'
alias la='eza -lah --icons'
alias dotfiles="cd ~/.config/dotfiles/"

starship init fish | source

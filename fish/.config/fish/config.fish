if status is-interactive
# Commands to run in interactive sessions can go here
end

if test (uname) = Darwin
  /opt/homebrew/bin/brew shellenv | source
end

alias ls='eza -lh --icons'
alias ll='eza -lh --icons'
alias la='eza -lah --icons'
alias dotfiles="cd ~/.config/dotfiles/"
export PATH="$PATH:$HOME/.cargo/bin:$HOME/.local/bin"

starship init fish | source

if status is-interactive
# Commands to run in interactive sessions can go here
end

bind up up-or-prefix-search
bind down down-or-prefix-search

if test (uname) = Darwin
  /opt/homebrew/bin/brew shellenv | source
end

alias ls='eza -lh --icons'
alias ll='eza -lh --icons'
alias la='eza -lah --icons'
alias dotfiles="cd ~/.config/dotfiles/"
export PATH="$PATH:$HOME/.cargo/bin:$HOME/.local/bin"

# deep seek api config, https://api-docs.deepseek.com/quick_start/agent_integrations/claude_code
export ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
read -gx ANTHROPIC_AUTH_TOKEN < $HOME/secrets/deep_seek_api
export ANTHROPIC_MODEL=deepseek-v4-pro[1m]
export ANTHROPIC_DEFAULT_OPUS_MODEL=deepseek-v4-pro[1m]
export ANTHROPIC_DEFAULT_SONNET_MODEL=deepseek-v4-pro[1m]
export ANTHROPIC_DEFAULT_HAIKU_MODEL=deepseek-v4-flash
export CLAUDE_CODE_SUBAGENT_MODEL=deepseek-v4-flash
export CLAUDE_CODE_EFFORT_LEVEL=max

starship init fish | source

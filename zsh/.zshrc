# ------------------------------------------------------------------------------
# PATH & ENVIRONMENT VARIABLES
# ------------------------------------------------------------------------------
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH="/Users/zack/.antigravity/antigravity/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export EDITOR='nvim'
export VISUAL='nvim'
export COLORTERM='truecolor'

# ------------------------------------------------------------------------------
# ZSH SETTINGS & COMPLETION
# ------------------------------------------------------------------------------
# Basic auto-completion
fpath=(/opt/homebrew/share/zsh-completions $fpath)
autoload -Uz compinit && compinit -u

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select


# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY

# ------------------------------------------------------------------------------
# ALIASES
# ------------------------------------------------------------------------------
# Modern replacements
alias cat='bat --paging=never'
alias ls='eza --group-directories-first --icons=always $@'
alias ll='eza --group-directories-first --icons=always $@ -lh'
alias la='eza --group-directories-first --icons=always $@ -a'
alias lla='eza --group-directories-first --icons=always $@ -lah'
alias lsa='eza --group-directories-first --icons=always $@ -lah'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'

# Network & Utility
alias ip='ifconfig | grep "inet "'
alias myip='curl ipinfo.io; echo'
alias snmap='nmap -f --data-length 8 --randomize-hosts -ttl 58'

# Config shortcuts
alias zshconfig='nvim ~/.zshrc'
alias reload='source ~/.zshrc'
alias vi='nvim'

# ------------------------------------------------------------------------------
# PROMPT & THEME
# ------------------------------------------------------------------------------
# Initialize Starship
eval "$(starship init zsh)"

# ------------------------------------------------------------------------------
# PLUGINS
# ------------------------------------------------------------------------------
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

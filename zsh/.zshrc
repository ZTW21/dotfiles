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

gblame() {
  local script='
import sys, time

def rel_time(ts):
    d = time.time() - ts
    if d < 3600:     return str(int(d/60)) + "m ago"
    if d < 86400:    return str(int(d/3600)) + "h ago"
    if d < 2592000:  return str(int(d/86400)) + "d ago"
    if d < 31536000: return str(int(d/2592000)) + "mo ago"
    return str(int(d/31536000)) + "y ago"

R="\033[0m"; DIM="\033[2m"; C="\033[36m"; Y="\033[33m"; B="\033[34m"
commits, lines_data, cur = {}, [], None

for raw in sys.stdin:
    line = raw.rstrip("\n")
    parts = line.split(" ")
    if len(parts) >= 3 and len(parts[0]) == 40 and all(c in "0123456789abcdef" for c in parts[0]):
        cur = parts[0]
        if cur not in commits: commits[cur] = {}
        commits[cur]["ln"] = int(parts[2])
    elif line.startswith("\t") and cur:
        lines_data.append({"h": cur, "ln": commits[cur].get("ln", 0), "code": line[1:]})
    elif cur:
        if line.startswith("author ") and not line.startswith("author-"):
            commits[cur]["author"] = line[7:]
        elif line.startswith("author-time "):
            commits[cur]["ts"] = int(line[12:])

lw = len(str(max((e["ln"] for e in lines_data), default=1)))
for e in lines_data:
    info = commits.get(e["h"], {})
    nc = e["h"] == "0" * 40
    h = (DIM if nc else B) + e["h"][:7] + R
    a = (DIM if nc else C) + info.get("author", "?")[:16].ljust(16) + R
    t = ("uncommitted" if nc else rel_time(info.get("ts", 0)))[:12].ljust(12)
    t = (DIM if nc else Y) + t + R
    n = DIM + str(e["ln"]).rjust(lw) + R
    print(h + "  " + a + "  " + t + "  " + n + "  " + e["code"])
'
  git blame --porcelain "$@" | python3 -c "$script" | less -RFX
}


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

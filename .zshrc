# =========================================================
# ⚡ FAST ZSH CONFIG — Optimized version of your setup
# =========================================================

# -------------------------------
# PATH logic
# -------------------------------
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$HOME/.local/bin:$PATH"
[[ ":$PATH:" != *":$HOME/bin:"* ]] && export PATH="$HOME/bin:$PATH"

export PATH="$PATH:/home/ruxir/.spicetify"
export PATH="$HOME/.bun/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/home/ruxir/.lmstudio/bin:$PATH"
export PATH="/home/ruxir/.opencode/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"

# depot_tools
[[ -d "$HOME/Applications/depot_tools" ]] && export PATH="$HOME/Applications/depot_tools:$PATH"

# Source local environment file
[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

# -------------------------------
# PYENV (lighter init)
# -------------------------------
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d "$PYENV_ROOT" ]]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    command -v pyenv >/dev/null && eval "$(pyenv init --path)"
fi

# -------------------------------
# ZINIT
# -------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ ! -d "$ZINIT_HOME" ]]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

# Async plugin loading (MUCH faster)
zinit ice wait lucid
zinit load zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit load zsh-users/zsh-completions

zinit ice wait lucid
zinit load Aloxaf/fzf-tab

zinit ice wait lucid
zinit load zsh-users/zsh-syntax-highlighting

zinit ice wait lucid
zinit snippet OMZP::git

zinit ice wait lucid
zinit snippet OMZP::sudo

zinit ice wait lucid
zinit snippet OMZP::command-not-found


# -------------------------------
# COMPLETION (optimized)
# -------------------------------
autoload -Uz compinit
compinit -C -d ~/.cache/zcompdump

# -------------------------------
# Bindkeys
# -------------------------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Ctrl + Arrow word navigation (works in Ghostty, Alacritty, Kitty)

# Ctrl + Left Arrow → move backward one word
bindkey '^[[1;5D' backward-word

# Ctrl + Right Arrow → move forward one word
bindkey '^[[1;5C' forward-word

# Ctrl + Backspace → delete previous word
# Normal backspace should delete ONE character
bindkey '^?' backward-delete-char

# Ctrl+Backspace deletes whole word (better behaviour)
bindkey '^H' backward-kill-word

# Alt + Left/Right word movement (very fast muscle memory)
bindkey '^[b' backward-word
bindkey '^[f' forward-word

# Ctrl + W delete previous word
bindkey '^W' backward-kill-word

# -------------------------------
# History
# -------------------------------
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory sharehistory
setopt hist_ignore_space hist_ignore_all_dups
setopt hist_save_no_dups hist_ignore_dups hist_find_no_dups

# -------------------------------
# Completion styles
# -------------------------------
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# -------------------------------
# Environment
# -------------------------------
export EDITOR=helix
export VISUAL=code
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# -------------------------------
# Aliases
# -------------------------------
alias c='clear'
alias vim='helix'
alias emacs="emacsclient -c -a 'emacs'"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias :q='exit'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Safe eza alias: use eza only if it both exists AND runs correctly
if command -v eza >/dev/null 2>&1 && eza --version >/dev/null 2>&1; then
    alias ls='eza -al --color=always --group-directories-first --icons'
    alias la='eza -a --color=always --group-directories-first --icons'
    alias ll='eza -l --color=always --group-directories-first --icons'
    alias lt='eza -aT --color=always --group-directories-first --icons'
    alias l.="eza -a | grep -e '^\.'"
else
    alias ls='ls --color'
    alias la='ls -la --color'
    alias ll='ls -l --color'
fi

# Package aliases
alias update="yay -Syu && flatpak update"
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)| yay -Yc'
alias mirror="sudo cachyos-rate-mirrors"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias u='sudo pacman -Syyu'
alias ys='yay -Ss'
alias s='pacman -Ss'
alias i='sudo pacman -S'
alias yi='yay -S'
alias r='sudo pacman -R'
alias rns='sudo pacman -Rns'
alias q='pacman -Qs'

# System aliases
alias lock='loginctl lock-session'
alias hw='hwinfo --short'
alias jctl="journalctl -p 3 -xb"

# Fun
alias please='sudo'
alias apt='man pacman'
alias apt-get='man pacman'
alias tb='nc termbin.com 9999'

# Gist sync
alias gist='gh gist edit a287d06d1c776424622e8772d4eb56a0 -f .zshrc ~/.zshrc && echo "~/.zshrc synced to Gist!"'
# -------------------------------
# Functions
# -------------------------------
backup() { [[ -z "$1" ]] && echo "Usage: backup <file>" && return 1; cp "$1" "$1.bak"; }

copy() {
    if [[ $# -eq 2 && -d "$1" ]]; then
        local from="${1%/}"
        command cp -r "$from" "$2"
    else
        command cp "$@"
    fi
}

history() { builtin fc -li 1 }
reload_zsh() { source ~/.zshrc && echo "Zsh configuration reloaded!" }
edit_zsh_config() { $EDITOR ~/.zshrc }

# -------------------------------
# Lazy-loaded tools (HUGE SPEED BOOST)
# -------------------------------

# # NVM lazy load
# export NVM_DIR="$HOME/.nvm"
# nvm() {
#   unset -f nvm
#   [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
#   nvm "$@"
# }
#
# # Auto-load default Node version silently when npm/node is used
# load-nvm() {
#   unset -f node npm npx
#   [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
# }
#
# node() { load-nvm; node "$@"; }
# npm()  { load-nvm; npm "$@"; }
# npx()  { load-nvm; npx "$@"; }

# -------------------------------
# Shell integrations
# -------------------------------
command -v fzf >/dev/null && eval "$(fzf --zsh)"
command -v zoxide >/dev/null && eval "$(zoxide init --cmd cd zsh)"

# bun completion
[[ -s "/home/ruxir/.bun/_bun" ]] && source "/home/ruxir/.bun/_bun"

# -------------------------------
# PROMPT (load LAST)
# -------------------------------
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"


# opencode
export PATH=/home/ruxir/.opencode/bin:$PATH
alias oc=opencode

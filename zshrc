# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt EXTENDED_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE \
       HIST_REDUCE_BLANKS HIST_VERIFY SHARE_HISTORY INC_APPEND_HISTORY

# Shell options 
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS INTERACTIVE_COMMENTS \
       NO_BEEP EXTENDED_GLOB COMPLETE_IN_WORD
bindkey -e   # emacs keys

#  Completion
fpath=(/usr/share/zsh/site-functions $fpath)
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then compinit; else compinit -C; fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh/compcache

# Environment
export EDITOR=nvim VISUAL=nvim PAGER=less
export BAT_THEME="base16"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

# fzf (Ctrl-R history, Ctrl-T files, Alt-C dirs)
export FZF_DEFAULT_OPTS="--height=45% --layout=reverse --border=rounded --info=inline \
--color=bg+:#282828,bg:#181818,spinner:#86c1b9,hl:#ab4642,fg:#b8b8b8,header:#ab4642,\
info:#f7ca88,pointer:#86c1b9,marker:#86c1b9,fg+:#d8d8d8,prompt:#f7ca88,hl+:#ab4642"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window=down:3:wrap --bind '?:toggle-preview'"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range=:200 {}'"
export FZF_ALT_C_OPTS="--preview 'eza -T --color=always --icons -L2 {}'"
source <(fzf --zsh)

# Plugins
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#585858'
bindkey '^ ' autosuggest-accept        # Ctrl+Space accepts
bindkey '^[[Z' autosuggest-accept      # Shift+Tab also accepts

source /home/user/.oh-my-zsh/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up      # type text, then ↑/↓
bindkey '^[[B' history-substring-search-down
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

# zsh-syntax-highlighting must be sourced LAST among plugins
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Navigation
eval "$(zoxide init zsh --cmd cd)"     # smart cd: `cd proj` jumps to frecent dirs

# Key fixes
bindkey '^[[H'  beginning-of-line
bindkey '^[[F'  end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Aliases
alias c='clear'
alias ls='eza -a --icons --group-directories-first'
alias ll='eza -lah --icons --git --group-directories-first'
alias lt='eza -T --icons -L2'
alias cat='bat --paging=never'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias update='sudo dnf update'
alias orphans='sudo pacman -Rns $(pacman -Qtdq)'
alias g='git'
alias gs='git status -sb'
alias gl='git log --oneline --graph --decorate -20'

#  Prompt
eval "$(starship init zsh)"


export JAVA_HOME=$HOME/.jdks/openjdk-26
export PATH=$JAVA_HOME/bin:$PATH

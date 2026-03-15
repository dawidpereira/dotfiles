# Aliases
alias v='nvim'
alias vim='nvim'
alias ls='eza --icons --git'
alias l='eza -la --icons --git'
alias ll='eza -l --icons --git'
alias lt='eza --tree --level=2 --long --icons --git'
alias c='clear'
alias cl='clear'
alias as='aerospace'
alias cd='z'
alias ci='zi'

# Options
setopt AUTO_CD
setopt GLOB_DOTS
setopt INTERACTIVE_COMMENTS

# Git
alias gc='git commit -m'
alias gca='git commit -a -m'
alias gp='git push origin HEAD'
alias gpu='git pull origin'
alias gst='git status'
alias glog='git log --graph --topo-order --pretty='"'"'%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N'"'"' --abbrev-commit'
alias gdiff='git diff'
alias gco='git checkout'
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'

# K8s
alias k='kubectl'
alias ka='kubectl apply -f'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kdel='kubectl delete'
alias kl='kubectl logs -f'
alias kgpo='kubectl get pod'
alias kgd='kubectl get deployments'
alias kc='kubectx'
alias kns='kubens'
alias ke='kubectl exec -it'

# Quetty
alias quetty='~/repos/quetty/target/release/quetty'

# fzf defaults
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --exclude Library --exclude .Trash --exclude node_modules --max-depth 8'
export FZF_DEFAULT_OPTS='--layout=reverse --border'
export BAT_STYLE='numbers'
export BAT_THEME='Catppuccin Mocha'

# Functions
ff() {
  local file
  file=$(fd --type f --hidden --exclude .git --exclude Library --exclude .Trash --exclude node_modules --max-depth 8 | fzf --preview 'bat --color=always --line-range=:500 {}')
  [[ -n "$file" ]] && ${EDITOR:-nvim} "$file"
}

ffa() {
  local file
  file=$(fd --type f --hidden --no-ignore --exclude Library --exclude .Trash --exclude node_modules --max-depth 8 | fzf --preview 'bat --color=always --line-range=:500 {}')
  [[ -n "$file" ]] && ${EDITOR:-nvim} "$file"
}

fcd() {
  local dir
  dir=$(fd --type d --hidden --exclude .git --exclude Library --exclude .Trash --exclude node_modules --max-depth 8 | fzf --preview 'eza -la --icons --git {}')
  [[ -n "$dir" ]] && builtin cd "$dir"
}

fcda() {
  local dir
  dir=$(fd --type d --hidden --no-ignore --max-depth 8 | fzf --preview 'eza -la --icons --git {}')
  [[ -n "$dir" ]] && builtin cd "$dir"
}

frg() {
  local result file line
  result=$(rg --color=always --line-number --no-heading --smart-case --max-depth 8 \
    --glob '!Library' --glob '!.Trash' --glob '!node_modules' "${*:-}" 2>/dev/null |
    fzf --ansi --delimiter : \
      --preview 'bat --color=always --highlight-line {2} {1}' \
      --preview-window '+{2}-/2')
  [[ -n "$result" ]] || return
  file=$(echo "$result" | cut -d: -f1)
  line=$(echo "$result" | cut -d: -f2)
  ${EDITOR:-nvim} "+$line" "$file"
}

frga() {
  local result file line
  result=$(rg --color=always --line-number --no-heading --smart-case --hidden --no-ignore --max-depth 8 \
    --glob '!Library' --glob '!.Trash' --glob '!node_modules' "${*:-}" 2>/dev/null |
    fzf --ansi --delimiter : \
      --preview 'bat --color=always --highlight-line {2} {1}' \
      --preview-window '+{2}-/2')
  [[ -n "$result" ]] || return
  file=$(echo "$result" | cut -d: -f1)
  line=$(echo "$result" | cut -d: -f2)
  ${EDITOR:-nvim} "+$line" "$file"
}

tmux_connect_sesh() {
  sesh connect "$(
    sesh list --icons | fzf-tmux -p 80%,70% --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
      --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
      --bind 'tab:down,btab:up' \
      --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
      --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
      --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
      --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
      --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
      --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
      --preview-window 'right:55%' \
      --preview 'sesh preview {}'
  )"
}

# Completion system (full rebuild once every 24h, cached otherwise)
autoload -Uz compinit
() {
  setopt local_options extended_glob
  if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
  else
    compinit -C
  fi
}

# Plugins
_brew_prefix="$(brew --prefix)"
source "$_brew_prefix/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh"
source "$_brew_prefix/share/zsh-you-should-use/you-should-use.plugin.zsh"
source "$_brew_prefix/share/zsh-autopair/autopair.zsh"
source "$_brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$_brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
unset _brew_prefix

# fzf-tab configuration
zstyle ':fzf-tab:*' fzf-flags --layout=reverse --border
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -la --icons --git $realpath'
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza -la --icons --git $realpath'

# Tool integrations
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(suv init zsh)"
source <(carapace _carapace zsh)

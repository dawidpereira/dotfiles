alias v = nvim
alias vim = nvim
alias l = ls --all
alias c = clear
alias cl = clear
alias ll = ls -l
alias lt = eza --tree --level=2 --long --icons --git
alias as = aerospace
alias ci = zi
alias nixbuild = darwin-rebuild switch --flake ~/dotfiles/nix#m1

def ff [] {
    aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
}


# Git
alias gc = git commit -m
alias gca = git commit -a -m
alias gp = git push origin HEAD
alias gpu = git pull origin
alias gst = git status
alias glog = git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit
alias gdiff = git diff
alias gco = git checkout
alias gb = git branch
alias gba = git branch -a
alias gadd = git add
alias ga = git add -p
alias gcoall = git checkout -- .
alias gr = git remote
alias gre = git reset

# K8s
alias k = kubectl
alias ka = kubectl apply -f
alias kg = kubectl get
alias kd = kubectl describe
alias kdel = kubectl delete
alias kl = kubectl logs
alias kgpo = kubectl get pod
alias kgd = kubectl get deployments
alias kc = kubectx
alias kns = kubens
alias kl = kubectl logs -f
alias ke = kubectl exec -it


mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
source ~/.zoxide.nu

def tmux_connect_sesh [] {
    try {
        sesh connect (
            sesh list --icons | fzf-tmux -p 80%,70% --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' 
                --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find'
                --bind 'tab:down,btab:up'
                --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)'
                --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)'
                --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)'
                --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)'
                --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)'
                --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)'
                --preview-window 'right:55%'
                --preview 'sesh preview {}'
        )
    } catch {
        return
    }
}

source ~/.cache/carapace/init.nu

# Quetty Development Setup  
alias quetty = ^~/repos/quetty/target/release/quetty

# FILE SYSTEM
# ===========
alias ch='chmod '

alias f='find'
alias fd='find . -type d'
alias ff='find . -type f'
alias fl='find . -type l'
alias fdn='find . -type d -name'
alias ffn='find . -type f -name'
alias fln='find . -type l -name'
alias fdp='find . -type d -perm'
alias ffp='find . -type f -perm'
alias flp='find . -type l -perm'

if [[ -x "/usr/bin/dircolors" ]]; then

    alias ls='ls --color=auto'
    alias l='ls --color=auto'
    alias ll='ls -l --color=auto'
    alias la='ls -A --color=auto'
    alias lla='ls -lA --color=auto'
    alias lF='ls -F --color=auto'
else
    alias l='ls'
    alias ll='ls -l'
    alias la='ls -A'
    alias lla='ls -lA'
    alias lF='ls -F'
fi

alias mk='mkdir -p'
alias r='rm'
alias rr='rm -r'
alias rf='rm -f'
alias rrf='rm -rf'

# STRING MANIPULATION
# ===================
if [[ -x "/usr/bin/dircolors" ]]; then

    alias grep='grep --color=auto'
    alias g='grep --color=auto'
    alias gv='grep -v --color=auto'
    alias gi='grep -i --color=auto'
    alias gvi='grep -vi --color=auto'
else
    alias g='grep'
    alias gv='grep -v'
    alias gi='grep -i'
    alias gvi='grep -vi'
fi

# MISCELLANEOUS
# =============
alias c='clear'
alias jzero='journalctl --vacuum-size=1'

alias x='xargs'
alias xi='xargs -I {}'

alias pacs='sudo pacman -S --needed --noconfirm'
alias pacr='sudo pacman -Rs --noconfirm'
alias pacu='sudo pacman -Syu --noconfirm'
alias paclean='sudo pacman -Rns $(pacman -Qdtq) --noconfirm'

alias gits='git status'
alias gita='git add'
alias gitc='git commit -m'
alias gitp='git push'

alias v='nvim'
alias py='python3'
alias pyc='python3 -c'

[[ -x "/usr/bin/dircolors" ]] && alias ip='ip -color=auto'

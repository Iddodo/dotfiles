#
#fix for emacs tramp
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ '

ZSH_DISABLE_COMPFIX="true"


export PATH="$PATH:$HOME/.config/emacs/bin"
export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:/Users/ido/Library/Application Support/Coursier/bin"
export PATH="$PATH:$HOME/bin"
export SHELL=/bin/zsh
export VISUAL=nvim
export EDITOR=nvim


# NEVER AGAIN
TRASH=$HOME/.KittyTrash
function del() {
	mv "$@" $TRASH/
}

# Edit line in vim with ctrl-v:
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line


# zsh-autocomplete
source $HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# zsh-syntax-highlighting
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-history-substring-search
source $HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh
#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down
zstyle ':completion:*' menu select
zmodload zsh/complist

# powerlevel10k
source $HOME/.config/powerlevel10k/powerlevel10k.zsh-theme

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


eval "$(/opt/homebrew/bin/brew shellenv)"

# Aliases
alias vim=nvim
alias python_http_server="python3 -m http.server"
alias ibrew="arch -x86_64 /usr/local/bin/brew"
alias pg_run_serv="pg_ctl -D /opt/homebrew/var/postgresql@14 start"
alias ll="ls -ll"
alias genpass="LC_ALL=C tr -dc \"[:alnum:]\" < /dev/urandom | head -c 20 | pbcopy"
alias whereami="pwd -P"
alias whatami="readlink"
alias powershell="pwsh"
alias g++20='g++ -std=c++20'
alias python=python3.11
alias bytecode="javap -c"
alias vim=nvim
alias python_http_server="python3 -m http.server"
alias ibrew="arch -x86_64 /usr/local/bin/brew"
alias pg_run_serv="pg_ctl -D /opt/homebrew/var/postgresql@14 start"
alias ll="ls -ll"
alias genpass="LC_ALL=C tr -dc \"[:alnum:]\" < /dev/urandom | head -c 20 | pbcopy"
alias whereami="pwd -P"
alias whatami="readlink"
alias powershell="pwsh"
alias g++20='g++ -std=c++20'
alias python=python3.11
alias bytecode="javap -c"


# Useful commands
function merge_pdf() {
	"/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py"
}


function get_info() {
	cat ~/info/$@ | pbcopy
}


rcd () {
    tmp="$(mktemp)"
    ranger --choosedir="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"                                               
    fi
}


zshrc() { vim ~/.zshrc }
newdir() { mkdir -p $1 && cd $_ }
nvimrc() { ranger ~/.config/nvim/ }
nvimdir() { ranger ~/.config/nvim }
nvimsnips() { nvim ~/.config/nvim/lua/snippets.lua }
grabdir() { cp -r $1 . }
zshsrc() { source ~/.zshrc }
points() { ls -l $1 | awk '{print $11}' }
in() { cd $1 && ls }
dotfiles() { cd "${HOME}/git/dotfiles"}




#[ -f "/Users/ido/.ghcup/env" ] && source "/Users/ido/.ghcup/env" # ghcup-env

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

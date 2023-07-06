# fix for emacs tramp
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ '


export SHELL=/bin/zsh

# Edit line in vim with ctrl-v:
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line


## vi mode
#bindkey -v
#export KEYTIMEOUT=1
#
## Use vim keys in tab complete menu:
#bindkey -M menuselect 'h' vi-backward-char
#bindkey -M menuselect 'k' vi-up-line-or-history
#bindkey -M menuselect 'l' vi-forward-char
#bindkey -M menuselect 'j' vi-down-line-or-history
#bindkey -v '^?' backward-delete-char


# zsh-vi-mode
# source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

TRASH=$HOME/.KittyTrash

export VISUAL=nvim
export EDITOR=nvim

# NEVER AGAIN
function del() {
	mv "$@" $TRASH/
}

#alias rm=del
#

alias vim=nvim

function merge_pdf() {
	"/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py"
}


alias python_http_server="python3 -m http.server"

alias ibrew="arch -x86_64 /usr/local/bin/brew"

alias pg_run_serv="pg_ctl -D /opt/homebrew/var/postgresql@14 start"


function get_info() {
	cat ~/info/$@ | pbcopy
}


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
#brew update --force --quiet
#chmod -R go-w "$(brew --prefix)/share/zsh"


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

[[ -s /Users/ido/.autojump/etc/profile.d/autojump.sh ]] && source /Users/ido/.autojump/etc/profile.d/autojump.sh

autoload -Uz compinit && compinit -u

source /Users/ido/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

source ~/.zsh/command-not-found.plugin.zsh
#
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
#
## To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#
plugins=(zsh-history-substring-search)
#
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#bindkey -v
#export KEYTIMEOUT=1

zstyle ':completion:*' menu select
zmodload zsh/complist
export PATH=$PATH:/opt/homebrew/bin
#
#export VIRTUALENVWRAPPER_PYTHON=/opt/homebrew/bin/python3
#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/Devel
#source /opt/homebrew/bin/virtualenvwrapper.sh
#
#
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/ido/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ido/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ido/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ido/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#histdel(){
  #for h in $(seq $1 $2); do
    #history -d $1
  #done
  #history -d $(history 1 | awk '{print $1}')
#}
#
#histdeln(){
#
#history -d -$@--1
#}


get-infi() {
	yq $1 ~/Technion/info/infi2m.yaml | xargs
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

path+=("$HOME/.config/emacs/bin")
export PATH
export PATH="$PATH:$HOME/dev/flutter/bin"


# Useful commands
zshrc() { vim ~/.zshrc }
dirin() { mkdir -p $1 && cd $_ }

grabdir() { cp -r $1 . }


zshsrc() { source ~/.zshrc }

alias ll="ls -ll"

points() { ls -l $1 | awk '{print $11}' }

in() { cd $1 && ls }

dotfiles() { cd "${HOME}/git/dotfiles"}

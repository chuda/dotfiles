# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"
ZSH_THEME="bira-chu"
ZSH_THEME="ys"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git extract svn)

source $ZSH/oh-my-zsh.sh
zstyle :compinstall filename '/home/chuda/.zshrc'

#autoload -Uz compinit promptinit
#compinit

# Customize to your needs...
export PATH=/opt/android-sdk/platform-tools/:/opt/android-sdk/tools:/home/chuda/bin:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/sbin:/usr/local/sbin:/usr/local/games:/usr/games
export ANDROID_SDK="/opt/android-sdk"

function svndiff ()
{
  svn diff "${@}" | colordiff | less -R ;
}

function hgdiff ()
{
  hg diff "${@}" | colordiff | less -R ;
}

function meldsvn ()
{
  dir=`dirname $1`
  file=`basename $1`
  if [ -e "$dir/.svn/text-base/$file.svn-base" ]; then
    meld "$1" "$dir/.svn/text-base/$file.svn-base"
  else
    echo "$1 is not svn based"
  fi
}

alias svndiffvim='svn diff --diff-cmd=/home/chuda/bin/vimdiff'
alias diff='colordiff'
alias grep='grep --color=auto'
alias make='colormake'
alias gsh='gsh --password-file=/home/chuda/bin/gsh_pass '
alias ls='ls --group-directories-first --color'
ulimit -c unlimited
eval `ssh-agent -s`
`ssh-add ~/.ssh/* 2>/dev/null`

# Path to your oh-my-zsh installation.
export ZSH=/Users/deepak/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git gitignore mercurial
         gem rbenv bundler
         rails rake
         coffee node
         brew brew-cask
         heroku
         # TODO: PR pending for js-repl
         # at https://github.com/robbyrussell/oh-my-zsh/pull/4152/files
         # created a custom plugin now
         # alias jsc="/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc"
         js-repl
         cloudapp copyfile encode64
         frontend-search web-search
         jsontools urltools
         jira
         emoji-clock)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

############################################################
#### PERSONAL CONFIG #######################################
############################################################

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# TODO: issue at https://github.com/robbyrussell/oh-my-zsh/issues/4153
alias b='brew'
alias cw='cd ~/Code/work'
alias statuspost='pg_ctl status -D /usr/local/var/postgres -s'

# functions

function update_lappy() {
    brew update
    brew upgrade
    brew cleanup
    upgrade_oh_my_zsh
}

function mirror_work_heroku_db() {
    cw
    heroku pg:backups capture
    curl -o latest.dump `heroku pg:backups public-url`
    pg_restore --verbose --clean --no-acl --no-owner -h localhost -U deepak -d emami_backup latest.dump
}

# eg. crun hello,
# will execute:
# cc -Wall    hello.c   -o hello
function crun() {
    make $1 CFLAGS='-Wall'
    ./$1
}

# open man page with bwana
# Requires http://www.bruji.com/bwana/
# `manu` means man-ui
# TODO: PR pending at https://github.com/caskroom/homebrew-cask/pull/12563
function manu() {
    open "man:$1"
}

function github_dotfiles() {
    mkdir ~/Code/forks/deepak-dotfiles/.oh-my-zsh
    cp ~/.zshrc ~/Code/forks/deepak-dotfiles/
    cp -r ~/.oh-my-zsh/custom ~/Code/forks/deepak-dotfiles/.oh-my-zsh
    cd ~/Code/forks/deepak-dotfiles
    gst # git status
}

# file permissions

# TODO: issue at https://github.com/robbyrussell/oh-my-zsh/issues/4151
if [[ -f ~/.cloudapp ]]; then
    chmod 600 ~/.cloudapp;
fi

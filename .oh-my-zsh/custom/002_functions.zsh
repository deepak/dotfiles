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
    local repo_dir=$(ruby -e "puts File.expand_path(ARGV[0])" "Code/forks/deepak-dotfiles")
    local oh_my_zsh_dir="$repo_dir/.oh-my-zsh"
    echo $repo_dir
    echo $oh_my_zsh_dir
    mkdir -p ${oh_my_zsh_dir}

    cp ~/.zshrc ${repo_dir}
    cp -r ~/.oh-my-zsh/custom ${oh_my_zsh_dir}
    cd ${repo_dir}
    git status
}

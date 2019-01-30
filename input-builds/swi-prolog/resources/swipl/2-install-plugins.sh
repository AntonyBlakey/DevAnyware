#!/usr/bin/env zsh

source /swipl/zshenv

# usage: install_addin addin-name git-url git-commit
install_addin () {
    git clone -q "$2" "$1"
    git -C "$1" checkout -q "$3"
    # the prosqlite plugin lib directory must be removed?
    if [ "$1" = 'prosqlite' ] ; then rm -rf "$1/lib" ; fi
    swipl -g "pack_rebuild($1)" -t halt
    find "$1" -mindepth 1 -maxdepth 1 ! -name lib ! -name prolog ! -name pack.pl -exec rm -rf {} +
    find "$1" -name .git -exec rm -rf {} +
}

mkdir -p /swipl/lib/swipl/pack
cd /swipl/lib/swipl/pack

# install_addin space https://github.com/JanWielemaker/space.git cd6fefa63317a7a6effb61a1c5aee634ebe2ca05
# install_addin prosqlite https://github.com/nicos-angelopoulos/prosqlite.git 816cb2e45a5fb53290a763a3306e430b72c40794
# install_addin rocksdb https://github.com/JanWielemaker/rocksdb.git 93f29d8f298d73de5719b93516acc73e00610eed
# install_addin hdt https://github.com/JanWielemaker/hdt.git e0a0eff87fc3318434cb493690c570e1255ed30e
# install_addin rserve_client https://github.com/JanWielemaker/rserve_client.git 72838bbfa3976a83d19fb38bdae04378e30f4b0d
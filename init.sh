#! /usr/bin/env bash
set -eu -o pipefail
_wd=$(pwd)
_path=$(dirname $0 | xargs -i readlink -f {})

####
mkdir Benchmarks && cd Benchmarks
git init
# add .gitignore

git remote add origin git@github.com:d2jvkpn/Benchmarks.git
git pull git@github.com:d2jvkpn/Benchmarks.git master
git branch -M master

git config user.name d2jvkpn
git config user.email chenbin2018@protonmail.com

git add -A
git commit -m "init"

# git branch --set-upstream-to=origin/master master

git remote set-url --add origin git@github.com/d2jvkpn/pieces.git

#### golang gin
mkdir -p go-gin && cd go-gin && go mod init go-gin
go get github.com/gin-gonic/gin

#### rust actix-web
cargo new --bin rust-actix && cd rust-actix
cargo add actix_web serde_json structopt

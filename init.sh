#! /usr/bin/env bash
set -eu -o pipefail
_wd=$(pwd)
_path=$(dirname $0 | xargs -i readlink -f {})

#### installation
go install github.com/six-ddc/plow@latest

go version
# go version go1.19.4 linux/amd64

rustc --version
# rustc 1.67.0-nightly (53e4b9dd7 2022-12-04)

#### create Benchmarks
mkdir Benchmarks && cd Benchmarks
git init
# add .gitignore

git remote add origin git@github.com:d2jvkpn/Benchmarks.git
git pull git@github.com:d2jvkpn/Benchmarks.git master
# git push --set-upstream origin master
git branch --set-upstream-to=origin/master master
git branch -M master

git config user.name d2jvkpn
git config user.email chenbin2018@protonmail.com

git remote set-url --add origin git@gitlab.com:d2jvkpn/Benchmarks.git

git add -A
git commit -m "init"
git push --set-upstream origin master
git push

#### golang fasthttp
mkdir -p go-fasthttp && cd go-fasthttp && go mod init go-fasthttp
go get github.com/valyala/fasthttp

#### golang gin
mkdir -p go-gin && cd go-gin && go mod init go-gin
go get github.com/gin-gonic/gin

#### rust actix-web
cargo new --bin rust-actix && cd rust-actix
cargo add actix_web serde_json structopt

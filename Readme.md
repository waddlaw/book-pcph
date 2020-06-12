# Haskell による並列・並行プログラミング

- [Parallel and Concurrent Programming in Haskell](https://simonmar.github.io/pages/pcph.html)
- [O'reilly books jp](https://www.oreilly.co.jp/books/9784873116891/)
- [Haskell Platform](https://www.haskell.org/platform/)
- [ThreadScope - Haskell wiki](https://wiki.haskell.org/ThreadScope)
- [GHC ユーザガイド](https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/)
- [Hackage](https://hackage.haskell.org/)
- [Hoogle](https://hoogle.haskell.org/)
- [parconc-examples - Hackage](https://hackage.haskell.org/package/parconc-examples)
  - [github](https://github.com/simonmar/parconc-examples)

## 実行環境

```shell
$ stack --version
Version 2.3.1, Git revision de2a7b694f07de7e6cf17f8c92338c16286b2878 (8103 commits) x86_64 hpack-0.33.0

$ cabal -V
cabal-install version 3.2.0.0
compiled using version 3.2.0.0 of the Cabal library

$ ghc -V
The Glorious Glasgow Haskell Compilation System, version 8.8.3
```

## ThreadScope のインストール

- ghc-8.10 ではビルドできなかった。

```shell
$ sudo apt install libgtk2.0-dev

$ git clone https://github.com/haskell/ThreadScope.git
$ cd ThreadScope
$ cabal install

$ threadscope --version
ThreadScope version 0.2.13
```

windows 環境の場合はバイナリを直接ダウンロードした方が良いと思う。=> [v0.2.13](https://github.com/haskell/ThreadScope/releases/tag/v0.2.13)

web ベースのやつも存在する。イベントログをアップロードして使ってみようと思ったけど、上手くいかなかったのでちょっと違うアプリなのかもしれません。

- [speedscope.app](https://www.speedscope.app/)
  - [jlfwong/speedscope](https://github.com/jlfwong/speedscope)
  - [speedscope - Interactive Flamegraph Explorer](http://jamie-wong.com/post/speedscope/)

## コード

chapter | コード
--------|-------
ch02 | [rpar](/ch02/rpar), [par-sudoku](/ch02/par-sudoku)
ch03 | [strat](/ch03/strat), [kmeans](/ch03/kmeans)

## 依存関係のインストール

### repa-devil

```
$ sudo apt install libdevil-dev
```

### llvm-7

- [Raspberry PiでAArch64なGHCを動かす](https://qiita.com/mod_poppo/items/084455236e61e583176a)

GHC | LLVM
----|------
8.6 | 7
8.8 | 9

```shell
$ sudo apt install llvm-9
$ export PATH=/usr/lib/llvm-9/bin:$PATH
```

### CUDA

- [Ubuntu 18.04へのCUDAインストール方法](https://qiita.com/yukoba/items/4733e8602fa4acabcc35)

```shell
$ sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub

$ wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.1.168-1_amd64.deb
$ sudo dpkg -i cuda-repo-ubuntu1804_10.1.168-1_amd64.deb
$ sudo apt update

$ sudo apt install cuda-10-1 cuda-drivers
$ sudo reboot

$ rm cuda-repo-ubuntu1804_10.1.168-1_amd64.deb
```

```
export PATH="/usr/local/cuda-10.1/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda-10.1/lib64:$LD_LIBRARY_PATH"
```

```
$ sudo apt install libnvvm3
```
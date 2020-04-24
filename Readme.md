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
Version 2.1.3, Git revision 636e3a759d51127df2b62f90772def126cdf6d1f (7735 commits) x86_64 hpack-0.31.2

$ cabal -V
cabal-install version 3.2.0.0
compiled using version 3.2.0.0 of the Cabal library
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

## My正誤表

オライリーの書籍ページに正誤表があります。以下はそれに載っていないものです。

### ch02

#### p.xiii 目次

誤: 2.4 Deepseq
正: 2.4 DeepSeq

#### p.3 下から2行目

最後のスラッシュいらない。

誤: http://www.haskell.org/haskellwiki/ThreadScope/
正: http://www.haskell.org/haskellwiki/ThreadScope

#### p.6 下から4行目

誤: 「2章　基本の並列性」
正: 「2章　基本の並列性: Evalモナド」

#### p.13 上から5行目

誤: 2.4 Deepseq
正: 2.4 DeepSeq

#### p.18 下から2行目

誤: rpar/rseq
正: rpar/rpar

#### p.22 下から10行目

誤: 2.4 Deepseq
正: 2.4 DeepSeq

### ch03

#### p.40 3.3.1 の見出しの上の文章

誤: 65回の反復の後
正: 20回の反復の後
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

web ベースのやつも存在する。イベントログをアップロードして使ってみようと思ったけど、上手くいかなかったのでちょっと違うアプリなのかもしれません。

- [speedscope.app](https://www.speedscope.app/)
  - [jlfwong/speedscope](https://github.com/jlfwong/speedscope)
  - [speedscope - Interactive Flamegraph Explorer](http://jamie-wong.com/post/speedscope/)

## コード

chapter | コード
--------|-------
ch02 | [rpar](/ch02/rpar), [par-sudoku](/ch02/par-sudoku)

## My正誤表

オライリーの書籍ページに正誤表があります。以下はそれに載っていないものです。

### p.xiii 目次

誤: 2.4 Deepseq
正: 2.4 DeepSeq

### p.3 下から2行目

最後のスラッシュいらない。

誤: http://www.haskell.org/haskellwiki/ThreadScope/
正: http://www.haskell.org/haskellwiki/ThreadScope

### p.6 下から4行目

誤: 「2章　基本の並列性」
正: 「2章　基本の並列性: Evalモナド」

### p.13 上から5行目

誤: 2.4 Deepseq
正: 2.4 DeepSeq

### p.18 下から2行目

誤: rpar/rseq
正: rpar/rpar

### p.22 下から10行目

誤: 2.4 Deepseq
正: 2.4 DeepSeq

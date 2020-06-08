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

### ch04

#### p.72 timetable.hs のコード例

誤: `instance NFData Talk`
正: ``instance NFData Talk where rnf (Talk x) = x `seq` ()``

#### p.80 freeVars の型

誤: `Term -> [VarId]`
正: `Term -> Set VarId`

#### p.84 箇条書き5つ目

誤: 4.6 別のスケジューラを使う
正: 4.5 別のスケジューラを使う

### ch05

#### p.87 fromListUnboxed の実行結果

誤: `AUnboxed (Z :. 10) (fromList [1,2,3,4,5,6,7,8,9,10])`
正: `AUnboxed (Z :. 10) [1,2,3,4,5,6,7,8,9,10]`

誤: `AUnboxed ((Z :. 3) :. 5) (fromList [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])`
正: `AUnboxed ((Z :. 3) :. 5) [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]`

#### p.90 computeS の実行結果

誤: `AUnboxed (Z :. 10) (fromList [2,3,4,5,6,7,8,9,10,11])`
正: `AUnboxed (Z :. 10) [2,3,4,5,6,7,8,9,10,11]`

誤: `AUnboxed (Z :. 10) (fromList [2,5,10,17,26,37,50,65,82,101])`
正: `AUnboxed (Z :. 10) [2,5,10,17,26,37,50,65,82,101]`

誤: `AUnboxed (Z :. 10) (fromList [0,1,2,3,4,5,6,7,8,9])`
正: `AUnboxed (Z :. 10) [0,1,2,3,4,5,6,7,8,9]`

#### p.91 computeS の実行結果

誤: `AUnboxed (Z :. 10) (fromList [1,2,3,4,5,6,7,8,9,10])`
正: `AUnboxed (Z :. 10) [1,2,3,4,5,6,7,8,9,10]`

#### p.95 computeP の実行結果

誤: `AUnboxed (Z :. 5) (fromList [0,1,2,3,4])`
正: `AUnboxed (Z :. 5) [0,1,2,3,4]`

#### p.96 sumAllS の型

誤: `sumAllS :: (Num a, Shape sh, Source r a, Unbox a, Elt a) => Array r sh a -> a`
正: `sumAllS :: (Num a, Shape sh, Source r a) => Array r sh a -> a`

#### p.96 foldS の型

誤: `(Shape sh, Source r a, Elt a, Unbox a) => (a -> a -> a) -> a -> Array r (sh :. Int) a -> Array U sh a`
正: `(Shape sh, Source r a, Unbox a) => (a -> a -> a) -> a -> Array r (sh :. Int) a -> Array U sh a`

#### p.97 foldS の実行結果

誤: `AUnboxed (Z :. 6) (fromList [20,19,31,18,15,21])`
正: `AUnboxed (Z :. 6) [20,19,31,18,15,21]`

誤: `AUnboxed Z (fromList [31])`
正: `AUnboxed Z [31]`

#### p.97 foldP の型

誤: `foldP :: (Shape sh, Source r a, Elt a, Unbox a, Monad m) => (a->a->a) -> a -> Array r (sh:.Int) -> m (Array U sh a)`
正: `foldP :: (Shape sh, Source r a, Unbox a, Monad m) => (a->a->a) -> a -> Array r (sh:.Int) -> m (Array U sh a)`
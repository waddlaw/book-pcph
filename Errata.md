# My正誤表

オライリーの書籍ページに正誤表があります。以下はそれに載っていないものです。

## ch02

### p.xiii 目次

誤: 2.4 Deepseq

正: 2.4 DeepSeq

### p.3 下から2行目

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

## ch03

### p.40 3.3.1 の見出しの上の文章

誤: 65回の反復の後

正: 20回の反復の後

## ch04

### p.72 timetable.hs のコード例

誤: `instance NFData Talk`

正: ``instance NFData Talk where rnf (Talk x) = x `seq` ()``

### p.80 freeVars の型

誤: `Term -> [VarId]`

正: `Term -> Set VarId`

### p.84 箇条書き5つ目

誤: 4.6 別のスケジューラを使う

正: 4.5 別のスケジューラを使う

## ch05

### p.87 fromListUnboxed の実行結果

誤: `AUnboxed (Z :. 10) (fromList [1,2,3,4,5,6,7,8,9,10])`

正: `AUnboxed (Z :. 10) [1,2,3,4,5,6,7,8,9,10]`

---

誤: `AUnboxed ((Z :. 3) :. 5) (fromList [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])`

正: `AUnboxed ((Z :. 3) :. 5) [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]`

### p.90 computeS の実行結果

誤: `AUnboxed (Z :. 10) (fromList [2,3,4,5,6,7,8,9,10,11])`

正: `AUnboxed (Z :. 10) [2,3,4,5,6,7,8,9,10,11]`

---

誤: `AUnboxed (Z :. 10) (fromList [2,5,10,17,26,37,50,65,82,101])`

正: `AUnboxed (Z :. 10) [2,5,10,17,26,37,50,65,82,101]`

---

誤: `AUnboxed (Z :. 10) (fromList [0,1,2,3,4,5,6,7,8,9])`

正: `AUnboxed (Z :. 10) [0,1,2,3,4,5,6,7,8,9]`

### p.91 computeS の実行結果

誤: `AUnboxed (Z :. 10) (fromList [1,2,3,4,5,6,7,8,9,10])`

正: `AUnboxed (Z :. 10) [1,2,3,4,5,6,7,8,9,10]`

### p.95 computeP の実行結果

誤: `AUnboxed (Z :. 5) (fromList [0,1,2,3,4])`

正: `AUnboxed (Z :. 5) [0,1,2,3,4]`

### p.96 sumAllS の型

誤: `sumAllS :: (Num a, Shape sh, Source r a, Unbox a, Elt a) => Array r sh a -> a`

正: `sumAllS :: (Num a, Shape sh, Source r a) => Array r sh a -> a`

### p.96 foldS の型

誤: `(Shape sh, Source r a, Elt a, Unbox a) => (a -> a -> a) -> a -> Array r (sh :. Int) a -> Array U sh a`

正: `(Shape sh, Source r a, Unbox a) => (a -> a -> a) -> a -> Array r (sh :. Int) a -> Array U sh a`

### p.97 foldS の実行結果

誤: `AUnboxed (Z :. 6) (fromList [20,19,31,18,15,21])`

正: `AUnboxed (Z :. 6) [20,19,31,18,15,21]`

---

誤: `AUnboxed Z (fromList [31])`

正: `AUnboxed Z [31]`

### p.97 foldP の型

誤: `foldP :: (Shape sh, Source r a, Elt a, Unbox a, Monad m) => (a->a->a) -> a -> Array r (sh:.Int) -> m (Array U sh a)`

正: `foldP :: (Shape sh, Source r a, Unbox a, Monad m) => (a->a->a) -> a -> Array r (sh:.Int) -> m (Array U sh a)`

## ch06

### p.105 fromList の実行結果

誤: `Array (Z :. 10) [1,2,3,4,5,6,7,8,9,10]`

正: `Vector (Z :. 10) [1,2,3,4,5,6,7,8,9,10]`

---

誤: `Vector (Z :. 3 :. 5) [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]`

正:

```
Matrix (Z :. 3 :. 5) 
  [  1,  2,  3,  4,  5,
     6,  7,  8,  9, 10,
    11, 12, 13, 14, 15]
```

### p.106 fromList の実行結果

誤: `Array (Z :. 2 :. 3) [(1,1),(2,2),(3,3),(4,4),(5,5),(6,6)]`

正:

```
Matrix (Z :. 2 :. 3) 
  [ (1,1), (2,2), (3,3),
    (4,4), (5,5), (6,6)]
```

---

誤: `Array (Z :. 3 :. 5) [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]`

正:

```
Matrix (Z :. 3 :. 5) 
  [  2,  3,  4,  5,  6,
     7,  8,  9, 10, 11,
    12, 13, 14, 15, 16]
```

### p.107 A.map の型

誤:

```
A.map
  :: (Shape ix, Elt a, Elt b) =>
     (Exp a -> Exp b) -> Acc (Array ix a) -> Acc (Array ix b)
```

正:

```
A.map
  :: (Shape sh, Elt a, Elt b) =>
     (Exp a -> Exp b) -> Acc (Array sh a) -> Acc (Array sh b)
```

---

誤: `Array ix a`

正: `Array sh a`

---

誤: `Acc (Array ix a)`

正: `Acc (Array sh a)`

### p.107 run の式

誤: `run $ A.map (^2) (use arr)`

正: `run $ A.map (Prelude.^2) (use arr)`

### p.107 run の実行結果

誤: `Array (Z :. 3 :. 5) [1,4,9,16,25,36,49,64,81,100,121,144,169,196,225]`

正:

```
Matrix (Z :. 3 :. 5) 
  [   1,   4,   9,  16,  25,
     36,  49,  64,  81, 100,
    121, 144, 169, 196, 225]
```

### p.108 run の実行結果

誤: `Array (Z) [3]`

正: `Scalar Z [3]`

### p.109 (!) の型


誤: `(Shape ix, Elt e) => Acc (Array ix e) -> Exp ix -> Exp e`

正: `(Shape sh, Elt e) => Acc (Array sh e) -> Exp sh -> Exp e`

---

誤: `Acc (Array ix e)`

正: `Acc (Array sh e)`

---

誤: `Exp ix`

正: `Exp sh`

### p.109 index1 の型

誤: `Exp Int -> Exp (Z :. Int)`

正: `Elt i => Exp i -> Exp (Z :. i)`

### p.109 run の実行結果

誤: `Array (Z) [4]`

正: `Scalar Z [4]`

### p.109 enumFromN のクラス制約

誤: `(Shape sh, Elt e, IsNum e)`

正: `(Shape sh, Elt e, Num (Exp e), FromIntegral Int e)`

### p.109 enumFromStepN のクラス制約

誤: `(Shape sh, Elt e, IsNum e)`

正: `(Shape sh, Elt e, Num (Exp e), FromIntegral Int e)`

### p.109 最後の行

誤: `3列5行`

正: `3行5列`

### p.110 run の実行結果

誤: `Array (Z :. 3 :. 5) [15,14,13,12,11,10,9,8,7,6,5,4,3,2,1]`

正:

```
Matrix (Z :. 3 :. 5) 
  [ 15, 14, 13, 12, 11,
    10,  9,  8,  7,  6,
     5,  4,  3,  2,  1]
```

### p.110 generate 関数の型

誤: `(Shape ix, Elt a) => Exp ix -> (Exp ix -> Exp a) -> Acc (Array ix a)`

正: `(Shape sh, Elt a) => Exp sh -> (Exp sh -> Exp a) -> Acc (Array sh a)`

---

誤: `Exp ix`

正: `Exp sh`

### p.110 run の式

誤: `run $ generate (index2 3 5) (\ix -> let Z:.y:.x = unlift ix in x+y)`

正: `run $ generate (index2 3 5) (\ix -> let Z:.y:.x = unlift ix in x+y) :: Array DIM2 Int`

### p.110 run の実行結果

誤: `Array (Z :. 3 :. 5) [0,1,2,3,4,1,2,3,4,5,2,3,4,5,6]`

正:

```
Matrix (Z :. 3 :. 5) 
  [ 0, 1, 2, 3, 4,
    1, 2, 3, 4, 5,
    2, 3, 4, 5, 6]
```

### p.110 unlift の型

誤: `Exp (Z :. Int :. Int) -> Z :. Exp Int :. Exp Int`

正: `Unlift c e => c (Plain e) -> e`

### p.111 index2 の型

誤: `Exp Int -> Exp Int -> Exp DIM2`

正: `Elt i => Exp i -> Exp i -> Exp ((Z :. i) :. i)`

### p.111 lift の型

誤: `Z :. Exp Int :. Exp Int -> Exp (Z :. Int :. Int)`

正: `Lift c e => e -> c (Plain e)`

### p.111 zipWith の型

誤:

```
zipWith :: (Shape ix, Elt a, Elt b, Elt c)
        => (Exp a -> Exp b -> Exp c)
        -> Acc (Array ix a) -> Acc (Array ix b)
        -> Acc (Array ix c)
```

正:

```
zipWith :: (Shape sh, Elt a, Elt b, Elt c)
        => (Exp a -> Exp b -> Exp c)
        -> Acc (Array sh a) -> Acc (Array sh b)
        -> Acc (Array sh c)
```

### p.111 run の結果

誤: `Array (Z :. 2 :. 3) [7,7,7,7,7,7]`

正:

```
Matrix (Z :. 2 :. 3) 
  [ 7, 7, 7,
    7, 7, 7]
```

---

誤: `Array (Z :. 2 :. 3) [11,22,33,64,75,86]`

正:

```
Matrix (Z :. 2 :. 3) 
  [ 1, 2, 3,
    4, 5, 6]
```

### p.112 constant の型

誤: `Elt t => t -> Exp t`

正: `Elt e => e -> Exp e`

### p.121 真ん中

誤: `「6.7 Acc の中で配列を作る」`

正: `「6.6 Acc の中で配列を作る」`

## ch07

### p.126 注釈が無い

誤：注釈1が無い

### p.130 箇条書き1つめ

誤: `メッセージを渡すの使えます`

正: `メッセージを渡すのに使えます`

## ch08

### p.151 finally の定義

誤:

```hs
finally io after = do
  io `onException` after
  after
```

正:

```hs
finally io after = do
  r <- io `onException` after
  _ <- after
  return r
```

## ch09

### p.162 uninterruptibleMask の型

誤: `uninterruptibleMask :: ((IO a -> IO a) -> IO b) -> IO b`

正: `uninterruptibleMask :: ((forall a. IO a -> IO a) -> IO b) -> IO b`
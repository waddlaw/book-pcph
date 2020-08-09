# 13章 スレッドを用いた並列プログラミング

- 並行性
  - 複数のURLを同時にダウンロードする
  - 高速化を達成するのに複数のプロセッサを必要としないため、並列性ではない
- 並行性は並列性を実現するためにも使われる
- 並列プログラミングのモデル (Eval 戦略、Par モナド) が使えない問題
  - I/O をしなければならない問題
  - 内部的な非決定性に依存するアルゴリズム
- 副作用があるということが必然的に並列プログラミングモデルを排除するというわけではない
  - 副作用のある計算を隠蔽するための ST モナドがある
  - ST モナドの中で並列性を用いることは困難

## 13.1 並行性を用いて並列性を達成する方法

- 多くの場合、作業するスレッドをいくつか生成することで並列性が得られる
- プログラムをマルチコアで走らせるには次の2つが必要
  - プログラムを `-threaded` 付きでコンパイルする
  - プログラムを `+RTS -Ncores` を付けて走らせる
- GHC の実行時システムは暇なコアが無いように自動的にスレッドを配置する
  - GHC の負荷分散アルゴリズムはそれほど洗練されていない
  - スケジュールポリシーが公平であることを期待してはいけない
  - スレッドがコアの割り当てを受けられない飢餓状態にならないようには努力してくれる
- 並列性の問題が並行性を使って並列性を実現するときにも起こる
  - 静的分割と動的分割の問題
  - 粒度の問題

## 13.2 例題: ファイル探索

- 引数
  - 探すべきファイル名
  - 探索の開始点となるディレクトリ
- ファイルシステムのメタデータがすでにメモリにキャッシュされているかどうかによって `I/Oバウンド`なプログラムになったり `計算バウンド`なプログラムになったりする

## 13.2.1 直列版

```hs
-- import System.Directory
getDirectoryContents :: FilePath -> IO [FilePath]

-- import System.Directory
doesDirectoryExist :: FilePath -> IO Bool
```

[findseq.hs](./findseq/findseq.hs)

- 著者の環境だと1.14秒
  - 全てのメタデータがキャッシュに載っている時の時間
- システムの find プログラムはおよそ4倍速く走る
  - String 型を使っている
  - ユニコード変換を実行している

```
λ time cabal run -v0 findseq findseq.cabal ~/Desktop/
Just "~/Desktop/hs-repos/waddlaw/book-pcph/ch13/findseq/findseq.cabal"

________________________________________________________
Executed in   11.69 secs   fish           external 
   usr time    2.35 secs  170.00 micros    2.35 secs 
   sys time    9.18 secs  757.00 micros    9.18 secs


λ time find ~/Desktop/ -name findseq.cabal
~/Desktop//hs-repos/waddlaw/book-pcph/ch13/findseq/findseq.cabal

________________________________________________________
Executed in    8.68 secs   fish           external 
   usr time    0.56 secs  169.00 micros    0.56 secs 
   sys time    6.51 secs  811.00 micros    6.51 secs
```

## 13.2.2 並列版

- 簡単には並列化できない
  - 複数のサブディレクトリを並行に検索して、あるサブディレクトリでファイルを見つけたら、他のサブディレクトリ上での検索はすぐに停止すべき
  - エラーが怒ったら、例外を正しく伝播すべき
- 直列版が持つ決定的振る舞いを維持するように注意
  - 部分木を探索中にエラーが発生しても、直列版のプログラムでは正しい答えが返るなら、並列版でもそうなっていなければならない

```hs
withAsync :: IO a -> (Async a -> IO b) -> IO b
withAsync io operation = bracket (async io) cancel operation
```

[findpar.hs](./findpar/findpar1.hs)

```hs
foldr :: (a -> b -> b) -> b -> [a] -> b

-- 例
foldr (+) 0 [1,2,3] == 1 + (2 + (3 + 0))

subfind s
  :: FilePath
  -> ([Async (Maybe FilePath)] -> IO (Maybe FilePath)) -- b
  ->  [Async (Maybe FilePath)] -> IO (Maybe FilePath)  -- b

foldr (subfind s)
  :: ([Async (Maybe FilePath)] -> IO (Maybe FilePath)) -- b
  -> [FilePath]                                        -- [a]
  -> [Async (Maybe FilePath)] -> IO (Maybe FilePath)   -- b

foldr (subfind s)
  :: ([Async (Maybe FilePath)] -> IO (Maybe FilePath))  -- dowait (初期値 e)
  -> [FilePath]                                         -- ps
  -> [Async (Maybe FilePath)]                           -- []
  -> IO (Maybe FilePath)

foldr (subfind s) dowait ps []
  = pn `subfind s` (... (p1 `subfind s` (p0 `subfind s` dowait))) []
```

## 13.2.3 性能とスケール

- 実際には存在しないファイルを探させて比較する
  - 木構造全体を走査させるため

```
λ cabal run -v0 -- findseq nonexistent ~/Desktop/ +RTS -s
Nothing
   4,451,087,376 bytes allocated in the heap
     119,396,104 bytes copied during GC
         837,304 bytes maximum residency (34 sample(s))
          33,416 bytes maximum slop
               0 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      4267 colls,     0 par    0.201s   0.227s     0.0001s    0.0035s
  Gen  1        34 colls,     0 par    0.013s   0.016s     0.0005s    0.0030s

  INIT    time    0.000s  (  0.009s elapsed)
  MUT     time    3.683s  ( 33.644s elapsed)
  GC      time    0.214s  (  0.243s elapsed)
  EXIT    time    0.000s  (  0.009s elapsed)
  Total   time    3.898s  ( 33.905s elapsed)

  %GC     time       0.0%  (0.0% elapsed)

  Alloc rate    1,208,596,965 bytes per MUT second

  Productivity  94.5% of total user, 99.2% of total elapsed

λ cabal run -v0 -- findpar1 nonexistent ~/Desktop/ +RTS -s
Nothing
   4,646,712,976 bytes allocated in the heap
   1,425,452,560 bytes copied during GC
      28,295,168 bytes maximum residency (52 sample(s))
         921,600 bytes maximum slop
              26 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      4413 colls,     0 par    3.436s   3.840s     0.0009s    0.0470s
  Gen  1        52 colls,     0 par    0.551s   0.649s     0.0125s    0.0359s

  TASKS: 4 (1 bound, 3 peak workers (3 total), using -N1)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.005s elapsed)
  MUT     time    6.226s  ( 55.499s elapsed)
  GC      time    3.988s  (  4.489s elapsed)
  EXIT    time    0.000s  (  0.006s elapsed)
  Total   time   10.214s  ( 59.999s elapsed)

  Alloc rate    746,381,380 bytes per MUT second

  Productivity  61.0% of total user, 92.5% of total elapsed

λ cabal run -v0 -- findpar1 nonexistent ~/Desktop/ +RTS -s -N2
Nothing
   4,647,432,784 bytes allocated in the heap
   1,210,235,880 bytes copied during GC
      29,349,248 bytes maximum residency (46 sample(s))
         957,056 bytes maximum slop
              27 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      2665 colls,  2665 par    2.809s   2.693s     0.0010s    0.0397s
  Gen  1        46 colls,    45 par    0.574s   0.462s     0.0101s    0.0733s

  Parallel GC work balance: 70.47% (serial 0%, perfect 100%)

  TASKS: 6 (1 bound, 5 peak workers (5 total), using -N2)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.005s elapsed)
  MUT     time    5.341s  ( 21.551s elapsed)
  GC      time    3.383s  (  3.155s elapsed)
  EXIT    time    0.000s  (  0.006s elapsed)
  Total   time    8.726s  ( 24.718s elapsed)

  Alloc rate    870,064,949 bytes per MUT second

  Productivity  61.2% of total user, 87.2% of total elapsed
```

## 13.2.4 セマフォを使ったスレッド数の制限

- 直列版に比べてそれほど高速化できていない理由は、並列版に他のオーバーヘッドがあるため
  - 粒度が細かすぎる
- 細粒度問題の解決法の1つはチャンクに分けること
  - Ref: 3.3.1 K平均法の並列化
  - 今回の場合は木構造状になっているので、簡単にはチャンクを作れない
- 分割統治法に対しては深さの閾値がより適している
  - Ref: 4.4 例: 会議の時間割
- ここでの問題
  - 自然には平衡していない
    - ほとんどの仕事が1つの深いサブディレクトリに集中する可能性がある
    - ひどく不均衡になる可能性がある
- やりたいこと
  - 生成されるスレッドの数を制限
  - すべてのコアがビジーになるような丁度よい数のスレッドを生成
- 実装
  - 生成できるスレッドの数を表現する共有のカウンタを保持
    - セマフォ
      - リソースの単位数
      - リソースの１単位を獲得する操作
      - それを開放する操作
  - ここでは、ノンブロッキングセマフォが欲しい
    - 使える単位が無かったら、直列アルゴリズムへフォールバックする

```hs
-- p.163
-- IO (a,b) のうち a: MVar に入れる値, b: 返す値
modifyMVar :: MVar a -> (a -> IO (a, b)) -> IO b
```

[findpar2.hs](./findpar/findpar2.hs)

```
λ cabal run -v0 -- findpar2 0 nonexistent ~/Desktop/ +RTS -N1 -s
Nothing
   4,520,422,448 bytes allocated in the heap
     158,937,008 bytes copied during GC
         847,776 bytes maximum residency (73 sample(s))
          33,176 bytes maximum slop
               0 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      4292 colls,     0 par    0.312s   0.338s     0.0001s    0.0023s
  Gen  1        73 colls,     0 par    0.030s   0.032s     0.0004s    0.0016s

  TASKS: 4 (1 bound, 3 peak workers (3 total), using -N1)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.006s elapsed)
  MUT     time    4.360s  ( 44.528s elapsed)
  GC      time    0.342s  (  0.370s elapsed)
  EXIT    time    0.000s  (  0.010s elapsed)
  Total   time    4.703s  ( 44.914s elapsed)

  Alloc rate    1,036,757,044 bytes per MUT second

  Productivity  92.7% of total user, 99.1% of total elapsed

λ cabal run -v0 -- findpar2 1 nonexistent ~/Desktop/ +RTS -N2 -s
Nothing
   4,525,142,920 bytes allocated in the heap
     168,846,504 bytes copied during GC
       1,179,256 bytes maximum residency (81 sample(s))
          51,968 bytes maximum slop
               1 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      3553 colls,  3553 par    0.748s   0.787s     0.0002s    0.1400s
  Gen  1        81 colls,    80 par    0.046s   0.030s     0.0004s    0.0010s

  Parallel GC work balance: 22.27% (serial 0%, perfect 100%)

  TASKS: 6 (1 bound, 5 peak workers (5 total), using -N2)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.006s elapsed)
  MUT     time    4.299s  ( 32.538s elapsed)
  GC      time    0.794s  (  0.817s elapsed)
  EXIT    time    0.000s  (  0.010s elapsed)
  Total   time    5.094s  ( 33.372s elapsed)

  Alloc rate    1,052,599,692 bytes per MUT second

  Productivity  84.4% of total user, 97.5% of total elapsed

λ cabal run -v0 -- findpar2 2 nonexistent ~/Desktop/ +RTS -N2 -s
Nothing
   4,524,111,328 bytes allocated in the heap
     204,707,936 bytes copied during GC
       1,034,840 bytes maximum residency (115 sample(s))
          40,544 bytes maximum slop
               0 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      2780 colls,  2780 par    0.434s   0.321s     0.0001s    0.0104s
  Gen  1       115 colls,   114 par    0.069s   0.048s     0.0004s    0.0026s

  Parallel GC work balance: 42.20% (serial 0%, perfect 100%)

  TASKS: 6 (1 bound, 5 peak workers (5 total), using -N2)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.010s elapsed)
  MUT     time    3.894s  ( 16.018s elapsed)
  GC      time    0.503s  (  0.369s elapsed)
  EXIT    time    0.000s  (  0.009s elapsed)
  Total   time    4.399s  ( 16.405s elapsed)

  Alloc rate    1,161,667,091 bytes per MUT second

  Productivity  88.5% of total user, 97.6% of total elapsed
```

---

- `STM` を使った解決策もあるが、ここでは `IORef` を使う
  - `STM` よりもオーバーヘッドが少ない

```hs
atomicModifyIORef :: IORef a -> (a -> (a,b)) -> IO b
```

[findpar3.hs](./findpar/findpar3.hs)

```
λ cabal run -v0 -- findpar3 nonexistent ~/Desktop/ +RTS -s -N2
Nothing
   4,524,830,824 bytes allocated in the heap
     257,920,296 bytes copied during GC
       1,784,264 bytes maximum residency (124 sample(s))
          57,144 bytes maximum slop
               1 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      2634 colls,  2634 par    0.443s   0.352s     0.0001s    0.0156s
  Gen  1       124 colls,   123 par    0.078s   0.055s     0.0004s    0.0028s

  Parallel GC work balance: 52.67% (serial 0%, perfect 100%)

  TASKS: 6 (1 bound, 5 peak workers (5 total), using -N2)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.006s elapsed)
  MUT     time    3.592s  ( 11.803s elapsed)
  GC      time    0.521s  (  0.407s elapsed)
  EXIT    time    0.000s  (  0.008s elapsed)
  Total   time    4.114s  ( 12.223s elapsed)

  Alloc rate    1,259,716,416 bytes per MUT second

  Productivity  87.3% of total user, 96.6% of total elapsed
```

## 13.2.5 ParIO モナド

- `ParIO` は `Par` モナドの亜種
  - `Control.Monad.Par.IO` モジュールで提供されている
- `Par` モナドとの違い
  - `IO` 操作ができる。(`liftIO` で持ち上げる)
  - 純粋な `runPar` 関数が使えない。代わりに `runParIO` を使う
- `ParIO` 計算は決定的であることが保証されていない
- IOモナド内で並列プログラミングをするなら `ParIO` が理想的

[findpar4.hs](./findpar/findpar4.hs)

```
λ cabal run -v0 -- findpar4 nonexistent ~/Desktop/ +RTS -s -N2
Nothing
   4,652,657,448 bytes allocated in the heap
     238,041,664 bytes copied during GC
       2,541,528 bytes maximum residency (68 sample(s))
          90,840 bytes maximum slop
               2 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      2778 colls,  2778 par    0.705s   1.204s     0.0004s    0.0474s
  Gen  1        68 colls,    67 par    0.090s   0.076s     0.0011s    0.0108s

  Parallel GC work balance: 43.31% (serial 0%, perfect 100%)

  TASKS: 6 (1 bound, 5 peak workers (5 total), using -N2)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.006s elapsed)
  MUT     time    4.871s  ( 17.957s elapsed)
  GC      time    0.795s  (  1.280s elapsed)
  EXIT    time    0.000s  (  0.008s elapsed)
  Total   time    5.666s  ( 19.251s elapsed)

  Alloc rate    955,267,177 bytes per MUT second

  Productivity  86.0% of total user, 93.3% of total elapsed
```

- 高速化の理由
  - 何らかの共有状態に頼る必要が無くなったため
  - `fork` はとても安価
  - `Par` モナドには注意深く調整されたワークスチールスケジューラが実装されているため
- `ParIO` にはエラー処理が無い
  - 修正することは可能
  - [findpar5.hs](./findpar/findpar5.hs)
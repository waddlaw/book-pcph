## rpar

実験 | time1 | time 2 | 考察
-----|------|--------|-------
並列化無し | 0.00s | 1.76s
rpar/rpar | 0.00s | 1.14s
rpar/rseq | 0.69s | 1.12s | 奇跡的に時間の短い方を指定したため並列化の効果有り
rpar/rseq/rseq | 1.12s | 1.12s
rpar/rpar/rseq/rseq | 1.08s | 1.08s
rseq/rseq | 1.78s | 1.78s | 両方とも `rseq` で止まるため効果無し
rseq/rpar | 1.12s | 1.81s | `rseq` を時間が長くかかる方に指定したため効果無し

---

並列化無し

```shell
$ cabal run -- rpar 1
time: 0.00s
(24157817,14930352)
time: 1.76s
```

rpar/rpar

```shell
$ cabal run -- rpar 1 +RTS -N2
time: 0.00s
(24157817,14930352)
time: 1.14s
```

rpar/rseq

```shell
$ cabal run -- rpar 2 +RTS -N2
time: 0.69s
(24157817,14930352)
time: 1.12s
```

rpar/rseq/rseq

```shell
$ cabal run -- rpar 3 +RTS -N2
time: 1.12s
(24157817,14930352)
time: 1.12s
```

---

rpar/rpar/rseq/rseq

```shell
$ cabal run -- rpar 4 +RTS -N2
time: 1.08s
(24157817,14930352)
time: 1.08s
```

rseq/rseq

```shell
$ cabal run -- rpar 5 +RTS -N2
time: 1.78s
(24157817,14930352)
time: 1.78s
```

rseq/rpar

```shell
$ cabal run -- rpar 6 +RTS -N2
time: 1.12s
(24157817,14930352)
time: 1.81s
```
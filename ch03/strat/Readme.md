## strat

実行時オプション | CPU time | elapsed | 速度向上
---------|--------|--------|-------
`-s -N1` | 1.788s | 1.790s | -    
`-s -N2` | 1.844s | 1.141s | 1.57
`-s -N3` | 1.948s | 1.172s | 1.53
`-s -N4` | 2.056s | 1.191s | 1.50

---

並列化無し

```shell
$ cabal exec -- strat +RTS -s -N1
```
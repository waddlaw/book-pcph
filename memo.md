# MEMO

- [Control.Parallel.Strategies](https://hackage.haskell.org/package/parallel/docs/Control-Parallel-Strategies.html)

```hs
type Strategy a = a -> Eval a

rpar :: Strategy a
rparWith :: Strategy a -> Strategy a

r0 :: Strategy a
rseq :: Strategy a
rdeepseq :: NFData a => Strategy a

parMap :: Strategy b -> (a -> b) -> [a] -> [b]
parList :: Strategy a -> Strategy [a]
evalList :: Strategy a -> Strategy [a]
```
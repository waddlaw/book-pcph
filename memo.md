# MEMO

- [Control.Parallel.Strategies](https://hackage.haskell.org/package/parallel/docs/Control-Parallel-Strategies.html)

```hs
type Strategy a = a -> Eval a

using :: a -> Strategy a -> a
withStrategy :: Strategy a -> a -> a

rpar :: Strategy a
rparWith :: Strategy a -> Strategy a

r0 :: Strategy a
rseq :: Strategy a
rdeepseq :: NFData a => Strategy a

parMap :: Strategy b -> (a -> b) -> [a] -> [b]
parList :: Strategy a -> Strategy [a]
parListChunk :: Int -> Strategy a -> Strategy [a]
evalList :: Strategy a -> Strategy [a]

parBuffer :: Int -> Strategy a -> Strategy [a]
```
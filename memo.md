# MEMO

```hs
type Strategy a = a -> Eval a

rpar :: Strategy a
rseq :: Strategy a
```
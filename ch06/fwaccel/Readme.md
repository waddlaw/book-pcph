# fwaccel


## まとめ

    app    |         Total time
-----------|-------------------------------
fwaccel-gpu -O2     | 1.922s    (  3.730s elapsed)
fwdense1    -O2 -N7 | 192.747s  ( 37.881s elapsed)

### fwaccel-gpu -O2

```
$ cabal exec -- fwaccel-gpu 2000 +RTS -s
Scalar Z [-1526072448]
   1,070,045,976 bytes allocated in the heap
     511,626,976 bytes copied during GC
      62,487,120 bytes maximum residency (11 sample(s))
         177,584 bytes maximum slop
              59 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      1009 colls,     0 par    0.647s   0.657s     0.0007s    0.0019s
  Gen  1        11 colls,     0 par    0.393s   0.451s     0.0410s    0.1129s

  TASKS: 4 (1 bound, 3 peak workers (3 total), using -N1)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.000s elapsed)
  MUT     time    0.880s  (  2.621s elapsed)
  GC      time    1.040s  (  1.108s elapsed)
  EXIT    time    0.001s  (  0.001s elapsed)
  Total   time    1.922s  (  3.730s elapsed)

  Alloc rate    1,216,312,408 bytes per MUT second

  Productivity  45.8% of total user, 70.3% of total elapsed
```

### fwdense1 -O2 -N7

```
$ cabal exec -- fwdense1 2000 +RTS -s -N7
8000002000000
  64,324,973,104 bytes allocated in the heap
     535,261,384 bytes copied during GC
     136,004,152 bytes maximum residency (675 sample(s))
      23,358,920 bytes maximum slop
             129 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      1606 colls,  1606 par    1.597s   0.265s     0.0002s    0.0026s
  Gen  1       675 colls,   674 par    3.483s   0.836s     0.0012s    0.3226s

  Parallel GC work balance: 8.81% (serial 0%, perfect 100%)

  TASKS: 16 (1 bound, 15 peak workers (15 total), using -N7)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.001s elapsed)
  MUT     time  187.665s  ( 36.777s elapsed)
  GC      time    5.081s  (  1.101s elapsed)
  EXIT    time    0.001s  (  0.001s elapsed)
  Total   time  192.747s  ( 37.881s elapsed)

  Alloc rate    342,764,784 bytes per MUT second

  Productivity  97.4% of total user, 97.1% of total elapsed
```
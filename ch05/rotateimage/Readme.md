# rotateimage

## ライブラリのインストール

```
λ sudo apt install libdevil-dev
```

## まとめ

    app    |         Total time
-----------|-------------------------------
rotateimage -O2            | 0.356s  ( 0.360s elapsed)
rotateimage -O2 -N4        | 0.720s  ( 0.211s elapsed)
rotateimage -O2 -fllvm     | 0.276s  ( 0.290s elapsed)
rotateimage -O2 -fllvm -N4 | 0.621s  ( 0.201s elapsed)

### -O2

```
λ stack exec -- rotateimage 4 cat.jpg straight.jpg +RTS -srotateimage: Unable to the save the image to the file.
CallStack (from HasCallStack):
  error, called at Data/Array/Repa/IO/DevIL.hsc:141:9 in repa-devil-0.3.2.6-HZ7aV9clTlN3PJDhH4F5BS:Data.Array.Repa.IO.DevIL
      66,831,056 bytes allocated in the heap
         104,376 bytes copied during GC
          55,552 bytes maximum residency (2 sample(s))
          26,368 bytes maximum slop
               0 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0        62 colls,     0 par    0.001s   0.001s     0.0000s    0.0001s
  Gen  1         2 colls,     0 par    0.000s   0.000s     0.0002s    0.0002s

  TASKS: 4 (1 bound, 3 peak workers (3 total), using -N1)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.001s elapsed)
  MUT     time    0.354s  (  0.357s elapsed)
  GC      time    0.001s  (  0.001s elapsed)
  EXIT    time    0.000s  (  0.001s elapsed)
  Total   time    0.356s  (  0.360s elapsed)

  Alloc rate    188,819,763 bytes per MUT second

  Productivity  99.3% of total user, 99.0% of total elapsed
```

### -O2 -N4

```
λ stack exec -- rotateimage 4 cat.jpg straight.jpg +RTS -s -N4
rotateimage: Unable to the save the image to the file.
CallStack (from HasCallStack):
  error, called at Data/Array/Repa/IO/DevIL.hsc:141:9 in repa-devil-0.3.2.6-HZ7aV9clTlN3PJDhH4F5BS:Data.Array.Repa.IO.DevIL
      66,880,352 bytes allocated in the heap
         179,952 bytes copied during GC
          92,984 bytes maximum residency (2 sample(s))
          54,472 bytes maximum slop
               0 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0        16 colls,    16 par    0.056s   0.001s     0.0000s    0.0001s
  Gen  1         2 colls,     1 par    0.009s   0.000s     0.0002s    0.0002s

  Parallel GC work balance: 75.22% (serial 0%, perfect 100%)

  TASKS: 10 (1 bound, 9 peak workers (9 total), using -N4)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.000s  (  0.001s elapsed)
  MUT     time    0.653s  (  0.202s elapsed)
  GC      time    0.065s  (  0.001s elapsed)
  EXIT    time    0.002s  (  0.007s elapsed)
  Total   time    0.720s  (  0.211s elapsed)

  Alloc rate    102,388,311 bytes per MUT second

  Productivity  90.7% of total user, 95.8% of total elapsed
```

### -O2 -fllvm

```
λ stack exec -- rotateimage 4 cat.jpg straight.jpg +RTS -s
rotateimage: Unable to the save the image to the file.
CallStack (from HasCallStack):
  error, called at Data/Array/Repa/IO/DevIL.hsc:141:9 in repa-devil-0.3.2.6-HZ7aV9clTlN3PJDhH4F5BS:Data.Array.Repa.IO.DevIL
      66,831,056 bytes allocated in the heap
         104,376 bytes copied during GC
          55,552 bytes maximum residency (2 sample(s))
          26,368 bytes maximum slop
               0 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0        62 colls,     0 par    0.001s   0.001s     0.0000s    0.0001s
  Gen  1         2 colls,     0 par    0.000s   0.000s     0.0002s    0.0002s

  TASKS: 4 (1 bound, 3 peak workers (3 total), using -N1)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.001s elapsed)
  MUT     time    0.274s  (  0.285s elapsed)
  GC      time    0.001s  (  0.001s elapsed)
  EXIT    time    0.000s  (  0.003s elapsed)
  Total   time    0.276s  (  0.290s elapsed)

  Alloc rate    243,707,948 bytes per MUT second

  Productivity  99.3% of total user, 98.3% of total elapsed
```

## -O2 -fllvm -N4

```
λ stack exec -- rotateimage 4 cat.jpg straight.jpg +RTS -s -N4
      66,832,632 bytes allocated in the heap
         227,856 bytes copied during GC
          85,544 bytes maximum residency (2 sample(s))
          53,720 bytes maximum slop
               0 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0        15 colls,    15 par    0.072s   0.000s     0.0000s    0.0001s
  Gen  1         2 colls,     1 par    0.001s   0.000s     0.0002s    0.0002s

  Parallel GC work balance: 71.57% (serial 0%, perfect 100%)

  TASKS: 10 (1 bound, 9 peak workers (9 total), using -N4)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.002s  (  0.001s elapsed)
  MUT     time    0.544s  (  0.195s elapsed)
  GC      time    0.074s  (  0.001s elapsed)
  EXIT    time    0.001s  (  0.004s elapsed)
  Total   time    0.621s  (  0.201s elapsed)

  Alloc rate    122,794,737 bytes per MUT second

  Productivity  87.7% of total user, 97.3% of total elapsed
```
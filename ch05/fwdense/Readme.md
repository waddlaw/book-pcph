# まとめ

    app    |         Total time
-----------|-------------------------------
fwdense  -O2            | 3.440s  ( 3.471s elapsed)
fwdense  -O2 -fllvm     | 1.968s  ( 1.984s elapsed)
fwdense1 -O2            | 4.003s  ( 4.020s elapsed)
fwdense1 -O2 -N4        | 8.131s  ( 3.781s elapsed)
fwdense1 -O2 -fllvm     | 2.370s  ( 2.421s elapsed)
fwdense1 -O2 -fllvm -N4 | 5.522s  ( 2.621s elapsed)

## fwdense

### -O2

```
λ stack exec -- fwdense 500 +RTS -s
31249875000
   1,020,983,544 bytes allocated in the heap
      23,458,480 bytes copied during GC
       8,046,040 bytes maximum residency (170 sample(s))
       1,395,240 bytes maximum slop
               7 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0       349 colls,     0 par    0.012s   0.017s     0.0000s    0.0022s
  Gen  1       170 colls,     0 par    0.034s   0.044s     0.0003s    0.0150s

  INIT    time    0.000s  (  0.000s elapsed)
  MUT     time    3.394s  (  3.410s elapsed)
  GC      time    0.046s  (  0.061s elapsed)
  EXIT    time    0.000s  (  0.000s elapsed)
  Total   time    3.440s  (  3.471s elapsed)

  %GC     time       0.0%  (0.0% elapsed)

  Alloc rate    300,860,026 bytes per MUT second

  Productivity  98.7% of total user, 98.2% of total elapsed
```

### -O2 -fllvm

```
λ stack exec -- fwdense 500 +RTS -s
31249875000
   1,020,983,544 bytes allocated in the heap
      23,458,480 bytes copied during GC
       8,046,040 bytes maximum residency (170 sample(s))
       1,395,240 bytes maximum slop
               7 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0       349 colls,     0 par    0.015s   0.014s     0.0000s    0.0016s
  Gen  1       170 colls,     0 par    0.037s   0.041s     0.0002s    0.0143s

  INIT    time    0.000s  (  0.000s elapsed)
  MUT     time    1.915s  (  1.928s elapsed)
  GC      time    0.052s  (  0.056s elapsed)
  EXIT    time    0.000s  (  0.000s elapsed)
  Total   time    1.968s  (  1.984s elapsed)

  %GC     time       0.0%  (0.0% elapsed)

  Alloc rate    533,167,659 bytes per MUT second

  Productivity  97.3% of total user, 97.2% of total elapsed
```

## fwdense1

### -O2

```
λ stack exec -- fwdense1 500 +RTS -s
31250125000
   1,021,123,104 bytes allocated in the heap
      25,940,000 bytes copied during GC
       8,046,824 bytes maximum residency (170 sample(s))
       1,390,360 bytes maximum slop
               7 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0       349 colls,     0 par    0.015s   0.016s     0.0000s    0.0022s
  Gen  1       170 colls,     0 par    0.041s   0.046s     0.0003s    0.0106s

  TASKS: 4 (1 bound, 3 peak workers (3 total), using -N1)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.001s elapsed)
  MUT     time    3.945s  (  3.951s elapsed)
  GC      time    0.056s  (  0.063s elapsed)
  EXIT    time    0.000s  (  0.005s elapsed)
  Total   time    4.003s  (  4.020s elapsed)

  Alloc rate    258,830,178 bytes per MUT second

  Productivity  98.6% of total user, 98.3% of total elapsed
```

### -O2 -N4

```
λ stack exec -- fwdense1 500 +RTS -s -N4
31250125000
   1,021,268,712 bytes allocated in the heap
      32,286,840 bytes copied during GC
       8,092,040 bytes maximum residency (170 sample(s))
       1,422,968 bytes maximum slop
               7 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0       349 colls,   349 par    0.746s   0.280s     0.0008s    0.0185s
  Gen  1       170 colls,   169 par    1.075s   0.387s     0.0023s    0.0225s

  Parallel GC work balance: 20.89% (serial 0%, perfect 100%)

  TASKS: 10 (1 bound, 9 peak workers (9 total), using -N4)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.001s elapsed)
  MUT     time    6.308s  (  3.107s elapsed)
  GC      time    1.821s  (  0.666s elapsed)
  EXIT    time    0.000s  (  0.006s elapsed)
  Total   time    8.131s  (  3.781s elapsed)

  Alloc rate    161,910,438 bytes per MUT second

  Productivity  77.6% of total user, 82.2% of total elapsed
```

### -O2 -fllvm

```
λ stack exec -- fwdense1 500 +RTS -s
31250125000
   1,021,125,120 bytes allocated in the heap
      25,943,480 bytes copied during GC
       8,046,824 bytes maximum residency (170 sample(s))
       1,390,360 bytes maximum slop
               7 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0       349 colls,     0 par    0.011s   0.015s     0.0000s    0.0016s
  Gen  1       170 colls,     0 par    0.037s   0.049s     0.0003s    0.0108s

  TASKS: 4 (1 bound, 3 peak workers (3 total), using -N1)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.000s  (  0.001s elapsed)
  MUT     time    2.322s  (  2.353s elapsed)
  GC      time    0.048s  (  0.063s elapsed)
  EXIT    time    0.001s  (  0.003s elapsed)
  Total   time    2.370s  (  2.421s elapsed)

  Alloc rate    439,833,770 bytes per MUT second

  Productivity  97.9% of total user, 97.2% of total elapsed
```

### -O2 -fllvm -N4

```
λ stack exec -- fwdense1 500 +RTS -s -N4
31250125000
   1,021,269,480 bytes allocated in the heap
      32,308,672 bytes copied during GC
       8,092,056 bytes maximum residency (170 sample(s))
       1,418,856 bytes maximum slop
               7 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0       349 colls,   349 par    0.911s   0.323s     0.0009s    0.0222s
  Gen  1       170 colls,   169 par    0.868s   0.316s     0.0019s    0.0220s

  Parallel GC work balance: 19.97% (serial 0%, perfect 100%)

  TASKS: 10 (1 bound, 9 peak workers (9 total), using -N4)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.001s elapsed)
  MUT     time    3.739s  (  1.978s elapsed)
  GC      time    1.780s  (  0.639s elapsed)
  EXIT    time    0.001s  (  0.004s elapsed)
  Total   time    5.522s  (  2.621s elapsed)

  Alloc rate    273,119,650 bytes per MUT second

  Productivity  67.7% of total user, 75.5% of total elapsed
```
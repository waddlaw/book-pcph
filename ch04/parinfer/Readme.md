# parinfer

app | Total time
-----|----------
-N1 | 2.486s  ( 2.490s elapsed)
-N2 | 2.545s  ( 1.301s elapsed)
-N3 | 3.838s  ( 1.351s elapsed)
-N4 | 5.079s  ( 1.391s elapsed)

```
$ stack exec -- parinfer <parinfer/benchmark.in +RTS -s
[("*",All . Int -> Int -> Int),("+",All . Int -> Int -> Int),("-",All . Int -> Int -> Int),("/",All . Int -> Int -> Int),("a",All a4095. a4095 -> a4095),("b",All a4095. a4095 -> a4095),("c",All a4095. a4095 -> a4095),("d",All a4095. a4095 -> a4095),("id",All a0. a0 -> a0)]
     370,612,840 bytes allocated in the heap
      54,557,272 bytes copied during GC
       1,885,688 bytes maximum residency (23 sample(s))
          29,016 bytes maximum slop
               1 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0       332 colls,     0 par    0.049s   0.050s     0.0001s    0.0006s
  Gen  1        23 colls,     0 par    0.035s   0.035s     0.0015s    0.0034s

  TASKS: 4 (1 bound, 3 peak workers (3 total), using -N1)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.001s elapsed)
  MUT     time    2.402s  (  2.404s elapsed)
  GC      time    0.084s  (  0.084s elapsed)
  EXIT    time    0.001s  (  0.002s elapsed)
  Total   time    2.486s  (  2.490s elapsed)

  Alloc rate    154,323,057 bytes per MUT second
```

---

```
$ stack exec -- parinfer <parinfer/benchmark.in +RTS -s -N2
[("*",All . Int -> Int -> Int),("+",All . Int -> Int -> Int),("-",All . Int -> Int -> Int),("/",All . Int -> Int -> Int),("a",All a4095. a4095 -> a4095),("b",All a4095. a4095 -> a4095),("c",All a4095. a4095 -> a4095),("d",All a4095. a4095 -> a4095),("id",All a0. a0 -> a0)]
     370,663,568 bytes allocated in the heap
      56,174,584 bytes copied during GC
       3,890,656 bytes maximum residency (14 sample(s))
          57,632 bytes maximum slop
               3 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0       203 colls,   203 par    0.352s   0.035s     0.0002s    0.0005s
  Gen  1        14 colls,    13 par    0.052s   0.022s     0.0016s    0.0036s

  Parallel GC work balance: 81.01% (serial 0%, perfect 100%)

  TASKS: 6 (1 bound, 5 peak workers (5 total), using -N2)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.001s elapsed)
  MUT     time    2.139s  (  1.238s elapsed)
  GC      time    0.404s  (  0.058s elapsed)
  EXIT    time    0.001s  (  0.004s elapsed)
  Total   time    2.545s  (  1.301s elapsed)

  Alloc rate    173,253,664 bytes per MUT second

  Productivity  84.1% of total user, 95.2% of total elapsed
```

---

```
$ stack exec -- parinfer <parinfer/benchmark.in +RTS -s -N3
[("*",All . Int -> Int -> Int),("+",All . Int -> Int -> Int),("-",All . Int -> Int -> Int),("/",All . Int -> Int -> Int),("a",All a4095. a4095 -> a4095),("b",All a4095. a4095 -> a4095),("c",All a4095. a4095 -> a4095),("d",All a4095. a4095 -> a4095),("id",All a0. a0 -> a0)]
     370,718,160 bytes allocated in the heap
      59,802,144 bytes copied during GC
       4,444,760 bytes maximum residency (12 sample(s))
          58,936 bytes maximum slop
               4 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0       188 colls,   188 par    0.633s   0.041s     0.0002s    0.0007s
  Gen  1        12 colls,    11 par    0.074s   0.021s     0.0018s    0.0031s

  Parallel GC work balance: 70.15% (serial 0%, perfect 100%)

  TASKS: 8 (1 bound, 7 peak workers (7 total), using -N3)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.000s  (  0.001s elapsed)
  MUT     time    3.130s  (  1.280s elapsed)
  GC      time    0.708s  (  0.062s elapsed)
  EXIT    time    0.001s  (  0.008s elapsed)
  Total   time    3.838s  (  1.351s elapsed)

  Alloc rate    118,454,536 bytes per MUT second

  Productivity  81.5% of total user, 94.8% of total elapsed
```

---

```
$ stack exec -- parinfer <parinfer/benchmark.in +RTS -s -N4
[("*",All . Int -> Int -> Int),("+",All . Int -> Int -> Int),("-",All . Int -> Int -> Int),("/",All . Int -> Int -> Int),("a",All a4095. a4095 -> a4095),("b",All a4095. a4095 -> a4095),("c",All a4095. a4095 -> a4095),("d",All a4095. a4095 -> a4095),("id",All a0. a0 -> a0)]
     370,770,520 bytes allocated in the heap
      58,442,272 bytes copied during GC
       6,422,704 bytes maximum residency (10 sample(s))
          65,320 bytes maximum slop
               6 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0       124 colls,   124 par    0.621s   0.048s     0.0004s    0.0017s
  Gen  1        10 colls,     9 par    0.093s   0.022s     0.0022s    0.0055s

  Parallel GC work balance: 81.83% (serial 0%, perfect 100%)

  TASKS: 10 (1 bound, 9 peak workers (9 total), using -N4)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.001s elapsed)
  MUT     time    4.362s  (  1.317s elapsed)
  GC      time    0.715s  (  0.070s elapsed)
  EXIT    time    0.001s  (  0.003s elapsed)
  Total   time    5.079s  (  1.391s elapsed)

  Alloc rate    84,998,872 bytes per MUT second

  Productivity  85.9% of total user, 94.7% of total elapsed
```
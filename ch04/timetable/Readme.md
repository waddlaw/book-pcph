# timetable

app | Total time
-----|----------
timetable.hs | 1.159s  ( 1.172s elapsed)
timetable1.hs | 1.094s  ( 1.110s elapsed)
timetable2.hs | 3.594s  (  3.631s elapsed)
timetable2.hs (-N4) | 8.097s  ( 2.401s elapsed)
timetable3.hs | 3.594s  ( 3.631s elapsed)
timetable3.hs (-N4) | 2.249s  (  0.621s elapsed)

```
$ stack exec -- timetable 4 3 11 10 3 +RTS -s
[Person {name = "P10", talks = [4,5,9]},Person {name = "P9", talks = [11,10,2]},Person {name = "P8", talks = [7,5,6]},Person {name = "P7", talks = [4,1,10]},Person {name = "P6", talks = [9,6,1]},Person {name = "P5", talks = [3,10,4]},Person {name = "P4", talks = [5,2,6]},Person {name = "P3", talks = [4,8,2]},Person {name = "P2", talks = [10,4,11]},Person {name = "P1", talks = [6,4,2]}]
31104
   2,658,295,432 bytes allocated in the heap
      11,094,792 bytes copied during GC
          66,864 bytes maximum residency (7 sample(s))
          29,320 bytes maximum slop
               0 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      2554 colls,     0 par    0.034s   0.033s     0.0000s    0.0001s
  Gen  1         7 colls,     0 par    0.001s   0.001s     0.0001s    0.0002s

  INIT    time    0.000s  (  0.000s elapsed)
  MUT     time    1.124s  (  1.138s elapsed)
  GC      time    0.035s  (  0.034s elapsed)
  EXIT    time    0.000s  (  0.000s elapsed)
  Total   time    1.159s  (  1.172s elapsed)

  %GC     time       0.0%  (0.0% elapsed)

  Alloc rate    2,364,179,661 bytes per MUT second

  Productivity  97.0% of total user, 97.1% of total elapsed
```

---

```
$ stack exec -- timetable1 4 3 11 10 3 +RTS -s
[Person {name = "P10", talks = [4,5,9]},Person {name = "P9", talks = [11,10,2]},Person {name = "P8", talks = [7,5,6]},Person {name = "P7", talks = [4,1,10]},Person {name = "P6", talks = [9,6,1]},Person {name = "P5", talks = [3,10,4]},Person {name = "P4", talks = [5,2,6]},Person {name = "P3", talks = [4,8,2]},Person {name = "P2", talks = [10,4,11]},Person {name = "P1", talks = [6,4,2]}]
31104
   2,665,262,728 bytes allocated in the heap
      11,536,224 bytes copied during GC
          67,048 bytes maximum residency (7 sample(s))
          29,320 bytes maximum slop
               0 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      2561 colls,     0 par    0.032s   0.031s     0.0000s    0.0001s
  Gen  1         7 colls,     0 par    0.001s   0.001s     0.0001s    0.0002s

  INIT    time    0.000s  (  0.000s elapsed)
  MUT     time    1.061s  (  1.077s elapsed)
  GC      time    0.033s  (  0.032s elapsed)
  EXIT    time    0.000s  (  0.000s elapsed)
  Total   time    1.094s  (  1.110s elapsed)

  %GC     time       0.0%  (0.0% elapsed)

  Alloc rate    2,512,753,657 bytes per MUT second
```

---

```
$ stack exec -- timetable2 4 3 11 10 3 +RTS -s
[Person {name = "P10", talks = [4,5,9]},Person {name = "P9", talks = [11,10,2]},Person {name = "P8", talks = [7,5,6]},Person {name = "P7", talks = [4,1,10]},Person {name = "P6", talks = [9,6,1]},Person {name = "P5", talks = [3,10,4]},Person {name = "P4", talks = [5,2,6]},Person {name = "P3", talks = [4,8,2]},Person {name = "P2", talks = [10,4,11]},Person {name = "P1", talks = [6,4,2]}]
31104
  11,195,194,288 bytes allocated in the heap
     512,260,440 bytes copied during GC
       3,951,368 bytes maximum residency (184 sample(s))
          60,440 bytes maximum slop
               3 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0     10574 colls,     0 par    0.654s   0.657s     0.0001s    0.0006s
  Gen  1       184 colls,     0 par    0.212s   0.219s     0.0012s    0.0035s

  TASKS: 4 (1 bound, 3 peak workers (3 total), using -N1)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.001s elapsed)
  MUT     time    2.726s  (  2.750s elapsed)
  GC      time    0.866s  (  0.875s elapsed)
  EXIT    time    0.000s  (  0.003s elapsed)
  Total   time    3.594s  (  3.631s elapsed)

  Alloc rate    4,106,316,460 bytes per MUT second

  Productivity  75.9% of total user, 75.8% of total elapsed
```

```
$ stack exec -- timetable2 4 3 11 10 3 +RTS -s -N4
[Person {name = "P10", talks = [4,5,9]},Person {name = "P9", talks = [11,10,2]},Person {name = "P8", talks = [7,5,6]},Person {name = "P7", talks = [4,1,10]},Person {name = "P6", talks = [9,6,1]},Person {name = "P5", talks = [3,10,4]},Person {name = "P4", talks = [5,2,6]},Person {name = "P3", talks = [4,8,2]},Person {name = "P2", talks = [10,4,11]},Person {name = "P1", talks = [6,4,2]}]
31104
  11,221,240,528 bytes allocated in the heap
     481,080,824 bytes copied during GC
       4,000,184 bytes maximum residency (156 sample(s))
         115,752 bytes maximum slop
               3 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      2836 colls,  2836 par    4.440s   0.599s     0.0002s    0.0030s
  Gen  1       156 colls,   155 par    0.995s   0.326s     0.0021s    0.0052s

  Parallel GC work balance: 56.29% (serial 0%, perfect 100%)

  TASKS: 10 (1 bound, 9 peak workers (9 total), using -N4)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.000s  (  0.001s elapsed)
  MUT     time    2.662s  (  1.466s elapsed)
  GC      time    5.435s  (  0.925s elapsed)
  EXIT    time    0.000s  (  0.008s elapsed)
  Total   time    8.097s  (  2.401s elapsed)
```

---

```
$ stack exec -- timetable3 4 3 11 10 3 +RTS -s
[Person {name = "P10", talks = [4,5,9]},Person {name = "P9", talks = [11,10,2]},Person {name = "P8", talks = [7,5,6]},Person {name = "P7", talks = [4,1,10]},Person {name = "P6", talks = [9,6,1]},Person {name = "P5", talks = [3,10,4]},Person {name = "P4", talks = [5,2,6]},Person {name = "P3", talks = [4,8,2]},Person {name = "P2", talks = [10,4,11]},Person {name = "P1", talks = [6,4,2]}]
31104
   3,364,633,768 bytes allocated in the heap
      26,976,568 bytes copied during GC
       3,630,160 bytes maximum residency (7 sample(s))
          35,760 bytes maximum slop
               3 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      3255 colls,     0 par    0.044s   0.044s     0.0000s    0.0004s
  Gen  1         7 colls,     0 par    0.006s   0.013s     0.0018s    0.0043s

  TASKS: 4 (1 bound, 3 peak workers (3 total), using -N1)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.002s  (  0.001s elapsed)
  MUT     time    1.103s  (  1.119s elapsed)
  GC      time    0.051s  (  0.057s elapsed)
  EXIT    time    0.000s  (  0.003s elapsed)
  Total   time    1.155s  (  1.180s elapsed)

  Alloc rate    3,050,551,986 bytes per MUT second

  Productivity  95.5% of total user, 94.8% of total elapsed
```

```
$ stack exec -- timetable3 4 3 11 10 3 +RTS -s -N4
[Person {name = "P10", talks = [4,5,9]},Person {name = "P9", talks = [11,10,2]},Person {name = "P8", talks = [7,5,6]},Person {name = "P7", talks = [4,1,10]},Person {name = "P6", talks = [9,6,1]},Person {name = "P5", talks = [3,10,4]},Person {name = "P4", talks = [5,2,6]},Person {name = "P3", talks = [4,8,2]},Person {name = "P2", talks = [10,4,11]},Person {name = "P1", talks = [6,4,2]}]
31104
   3,364,831,264 bytes allocated in the heap
      26,904,192 bytes copied during GC
       3,597,928 bytes maximum residency (7 sample(s))
         104,856 bytes maximum slop
               3 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0       872 colls,   872 par    1.331s   0.081s     0.0001s    0.0019s
  Gen  1         7 colls,     6 par    0.047s   0.014s     0.0021s    0.0047s

  Parallel GC work balance: 51.18% (serial 0%, perfect 100%)

  TASKS: 10 (1 bound, 9 peak workers (9 total), using -N4)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.002s  (  0.001s elapsed)
  MUT     time    0.868s  (  0.522s elapsed)
  GC      time    1.378s  (  0.095s elapsed)
  EXIT    time    0.001s  (  0.003s elapsed)
  Total   time    2.249s  (  0.621s elapsed)

  Alloc rate    3,874,560,723 bytes per MUT second

  Productivity  38.6% of total user, 84.0% of total elapsed
```
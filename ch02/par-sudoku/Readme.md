## par-sudoku

app | CPU time | elapsed | 速度向上 | SPARKS
----|----------|---------|---------|--------
sudoku1 | 1.349s | 1.349s | -    | 0
sudoku2 | 1.442s | 0.881s | 1.53 | 2
sudoku3 | 1.636s | 0.821s | 1.64 | 1000
sudoku4 | 1.603s | 0.811s | 1.66 | 1000

### sudoku1

```shell
$ cabal exec -- sudoku1 sudoku17.1000.txt +RTS -s
1000
   1,538,600,768 bytes allocated in the heap
      15,151,720 bytes copied during GC
         240,160 bytes maximum residency (7 sample(s))
          35,600 bytes maximum slop
               3 MiB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      1481 colls,     0 par    0.028s   0.027s     0.0000s    0.0003s
  Gen  1         7 colls,     0 par    0.002s   0.002s     0.0002s    0.0004s

  INIT    time    0.000s  (  0.000s elapsed)
  MUT     time    1.320s  (  1.320s elapsed)
  GC      time    0.029s  (  0.029s elapsed)
  EXIT    time    0.000s  (  0.000s elapsed)
  Total   time    1.349s  (  1.349s elapsed)

  %GC     time       0.0%  (0.0% elapsed)

  Alloc rate    1,165,809,078 bytes per MUT second

  Productivity  97.8% of total user, 97.8% of total elapsed
```

### sudoku2

```shell
$ cabal exec -- sudoku2 sudoku17.1000.txt +RTS -N2 -s
1000
   1,544,034,352 bytes allocated in the heap
      24,501,928 bytes copied during GC
       2,761,008 bytes maximum residency (6 sample(s))
         216,784 bytes maximum slop
              10 MiB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0       940 colls,   940 par    0.373s   0.032s     0.0000s    0.0007s
  Gen  1         6 colls,     5 par    0.017s   0.008s     0.0013s    0.0027s

  Parallel GC work balance: 65.75% (serial 0%, perfect 100%)

  TASKS: 6 (1 bound, 5 peak workers (5 total), using -N2)

  SPARKS: 2 (1 converted, 0 overflowed, 0 dud, 0 GC'd, 1 fizzled)

  INIT    time    0.001s  (  0.001s elapsed)
  MUT     time    1.051s  (  0.832s elapsed)
  GC      time    0.390s  (  0.040s elapsed)
  EXIT    time    0.001s  (  0.009s elapsed)
  Total   time    1.442s  (  0.881s elapsed)

  Alloc rate    1,469,137,040 bytes per MUT second

  Productivity  72.9% of total user, 94.4% of total elapsed
```

### sudoku3

```shell
$ cabal exec -- sudoku3 sudoku17.1000.txt +RTS -N2 -s
1000
   1,603,323,128 bytes allocated in the heap
      24,043,200 bytes copied during GC
       2,075,440 bytes maximum residency (13 sample(s))
          62,672 bytes maximum slop
               8 MiB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0       795 colls,   795 par    0.368s   0.030s     0.0000s    0.0006s
  Gen  1        13 colls,    12 par    0.019s   0.007s     0.0005s    0.0021s

  Parallel GC work balance: 69.24% (serial 0%, perfect 100%)

  TASKS: 6 (1 bound, 5 peak workers (5 total), using -N2)

  SPARKS: 1000 (1000 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.001s elapsed)
  MUT     time    1.247s  (  0.781s elapsed)
  GC      time    0.387s  (  0.037s elapsed)
  EXIT    time    0.001s  (  0.001s elapsed)
  Total   time    1.636s  (  0.821s elapsed)

  Alloc rate    1,286,129,898 bytes per MUT second

  Productivity  76.2% of total user, 95.2% of total elapsed
```

### sudoku4

```shell
$ cabal exec -- sudoku4 sudoku17.1000.txt +RTS -N2 -s
1000
   1,608,354,744 bytes allocated in the heap
      24,627,552 bytes copied during GC
       1,793,440 bytes maximum residency (14 sample(s))
          57,952 bytes maximum slop
               8 MiB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0       801 colls,   801 par    0.316s   0.029s     0.0000s    0.0012s
  Gen  1        14 colls,    13 par    0.022s   0.008s     0.0006s    0.0022s

  Parallel GC work balance: 72.59% (serial 0%, perfect 100%)

  TASKS: 6 (1 bound, 5 peak workers (5 total), using -N2)

  SPARKS: 1000 (999 converted, 0 overflowed, 0 dud, 0 GC'd, 1 fizzled)

  INIT    time    0.001s  (  0.001s elapsed)
  MUT     time    1.263s  (  0.768s elapsed)
  GC      time    0.338s  (  0.037s elapsed)
  EXIT    time    0.001s  (  0.004s elapsed)
  Total   time    1.603s  (  0.811s elapsed)

  Alloc rate    1,273,591,840 bytes per MUT second

  Productivity  78.8% of total user, 94.8% of total elapsed
```
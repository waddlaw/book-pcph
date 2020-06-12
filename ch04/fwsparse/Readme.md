# fwsparse

```
$ ghc -V
The Glorious Glasgow Haskell Compilation System, version 8.8.3
```

app | Total time
----|-------------
fwsparse | 18.444s  ( 18.470s elapsed)
fwsparse1 (-N1) | 7.917s  ( 7.901s elapsed)
fwsparse1 (-N4) | 15.868s  ( 5.881s elapsed)

```
$ stack exec -- fwsparse 1000 800 +RTS -s
552434
   5,700,217,328 bytes allocated in the heap
     183,871,856 bytes copied during GC
         507,376 bytes maximum residency (106 sample(s))
          29,320 bytes maximum slop
               0 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      5332 colls,     0 par    0.245s   0.242s     0.0000s    0.0002s
  Gen  1       106 colls,     0 par    0.042s   0.042s     0.0004s    0.0009s

  INIT    time    0.000s  (  0.000s elapsed)
  MUT     time   18.157s  ( 18.187s elapsed)
  GC      time    0.286s  (  0.283s elapsed)
  EXIT    time    0.000s  (  0.000s elapsed)
  Total   time   18.444s  ( 18.470s elapsed)

  %GC     time       0.0%  (0.0% elapsed)

  Alloc rate    313,934,343 bytes per MUT second

  Productivity  98.4% of total user, 98.5% of total elapsed
```

---

```
$ stack exec -- fwsparse1 1000 800 +RTS -s -N1
552434
     761,285,232 bytes allocated in the heap
     141,130,752 bytes copied during GC
         498,320 bytes maximum residency (10 sample(s))
          32,536 bytes maximum slop
               0 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0       702 colls,     0 par    0.221s   0.220s     0.0003s    0.0010s
  Gen  1        10 colls,     0 par    0.006s   0.006s     0.0006s    0.0010s

  TASKS: 4 (1 bound, 3 peak workers (3 total), using -N1)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.002s  (  0.002s elapsed)
  MUT     time    7.689s  (  7.665s elapsed)
  GC      time    0.226s  (  0.225s elapsed)
  EXIT    time    0.001s  (  0.008s elapsed)
  Total   time    7.917s  (  7.901s elapsed)

  Alloc rate    99,012,963 bytes per MUT second

  Productivity  97.1% of total user, 97.0% of total elapsed
```

---

```
$ stack exec -- fwsparse1 1000 800 +RTS -s -N4
552434
     848,742,680 bytes allocated in the heap
      85,941,776 bytes copied during GC
         314,832 bytes maximum residency (2 sample(s))
          62,000 bytes maximum slop
               0 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0       440 colls,   440 par    2.244s   0.853s     0.0019s    0.0231s
  Gen  1         2 colls,     1 par    0.002s   0.001s     0.0003s    0.0005s

  Parallel GC work balance: 40.18% (serial 0%, perfect 100%)

  TASKS: 10 (1 bound, 9 peak workers (9 total), using -N4)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.002s  (  0.001s elapsed)
  MUT     time   13.619s  (  5.017s elapsed)
  GC      time    2.246s  (  0.854s elapsed)
  EXIT    time    0.001s  (  0.009s elapsed)
  Total   time   15.868s  (  5.881s elapsed)

  Alloc rate    62,318,292 bytes per MUT second

  Productivity  85.8% of total user, 85.3% of total elapsed
```
# Ch15

## thredperf1

```
λ stack exec threadperf1 -- +RTS -s
   1,096,044,496 bytes allocated in the heap
   3,910,463,784 bytes copied during GC
     744,294,736 bytes maximum residency (12 sample(s))
     150,906,544 bytes maximum slop
             709 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      1038 colls,     0 par    0.554s   0.569s     0.0005s    0.0026s
  Gen  1        12 colls,     0 par    1.474s   2.144s     0.1787s    0.6813s

  INIT    time    0.000s  (  0.005s elapsed)
  MUT     time    0.507s  (  0.522s elapsed)
  GC      time    2.028s  (  2.714s elapsed)
  RP      time    0.000s  (  0.000s elapsed)
  PROF    time    0.000s  (  0.000s elapsed)
  EXIT    time    0.094s  (  0.097s elapsed)
  Total   time    2.630s  (  3.336s elapsed)

  %GC     time       0.0%  (0.0% elapsed)

  Alloc rate    2,159,991,518 bytes per MUT second

  Productivity  19.3% of total user, 15.6% of total elapsed
```

### -k400

```
λ stack exec -- threadperf1 +RTS -s -k400
 33,240,108,784 bytes allocated in the heap
   1,173,038,104 bytes copied during GC
  24,705,739,688 bytes maximum residency (15 sample(s))
       7,861,304 bytes maximum slop
           23561 MB total memory in use (3 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0     31469 colls,     0 par    2.642s   3.585s     0.0001s    0.3230s
  Gen  1        15 colls,     0 par    2.114s   5.705s     0.3803s    2.6678s

  INIT    time    0.000s  (  0.004s elapsed)
  MUT     time    4.519s  ( 31.334s elapsed)
  GC      time    4.756s  (  9.289s elapsed)
  RP      time    0.000s  (  0.000s elapsed)
  PROF    time    0.000s  (  0.000s elapsed)
  EXIT    time    0.037s  (  0.051s elapsed)
  Total   time    9.312s  ( 40.678s elapsed)

  %GC     time       0.0%  (0.0% elapsed)

  Alloc rate    7,355,282,151 bytes per MUT second

  Productivity  48.5% of total user, 77.0% of total elapsed
```

## thredperf2

```
λ stack exec -- threadperf2 +RTS -s
   1,153,010,120 bytes allocated in the heap
     285,381,272 bytes copied during GC
      65,259,608 bytes maximum residency (9 sample(s))
         477,096 bytes maximum slop
              62 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      1071 colls,     0 par    0.167s   0.190s     0.0002s    0.0072s
  Gen  1         9 colls,     0 par    0.126s   0.180s     0.0200s    0.1081s

  INIT    time    0.000s  (  0.004s elapsed)
  MUT     time    0.184s  (  0.189s elapsed)
  GC      time    0.294s  (  0.370s elapsed)
  EXIT    time    0.000s  (  0.012s elapsed)
  Total   time    0.478s  (  0.575s elapsed)

  %GC     time       0.0%  (0.0% elapsed)

  Alloc rate    6,268,130,776 bytes per MUT second

  Productivity  38.5% of total user, 32.9% of total elapsed
```
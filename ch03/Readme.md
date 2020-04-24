## 3.5 parBuffer

```
$ ls -l /usr/share/dict/words
/usr/share/dict/words -> /etc/dictionaries-common/words
$ ls -l /etc/dictionaries-common/words
/etc/dictionaries-common/words -> /usr/share/dict/american-english
$ du -sh /usr/share/dict/american-english
952K    /usr/share/dict/american-english
```

### プロファイリング結果

項目 | rsa | rsa1 | rsa2
----|-----|------|-------
maximum residency | 107KB | 2.5MB | 30KB
total memory | 0MB | 2MB | 0MB
elapsed | 6.132s (-N1) | 4.071s (-N4) | 3.251s (-N4)

rsa

```
$ stack exec -- rsa encrypt /usr/share/dict/words >/dev/null +RTS -s
   5,267,101,720 bytes allocated in the heap
       3,148,736 bytes copied during GC
         107,728 bytes maximum residency (3 sample(s))
          28,176 bytes maximum slop
               0 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      5126 colls,     0 par    0.061s   0.059s     0.0000s    0.0000s
  Gen  1         3 colls,     0 par    0.000s   0.000s     0.0001s    0.0001s

  INIT    time    0.000s  (  0.000s elapsed)
  MUT     time    6.050s  (  6.072s elapsed)
  GC      time    0.061s  (  0.059s elapsed)
  EXIT    time    0.000s  (  0.000s elapsed)
  Total   time    6.111s  (  6.132s elapsed)

  %GC     time       0.0%  (0.0% elapsed)

  Alloc rate    870,568,992 bytes per MUT second

  Productivity  99.0% of total user, 99.0% of total elapsed
```

rsa1

```
$ stack exec -- rsa1 encrypt /usr/share/dict/words >/dev/null +RTS -N4 -s
Stack has not been tested with GHC versions above 8.6, and using 8.8.2, this may fail
Stack has not been tested with Cabal versions above 2.4, but version 3.0.1.0 was found, this may fail
   5,831,116,928 bytes allocated in the heap
      15,512,792 bytes copied during GC
       2,541,824 bytes maximum residency (8 sample(s))
         567,040 bytes maximum slop
               2 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      2216 colls,  2216 par    4.136s   0.122s     0.0001s    0.0025s
  Gen  1         8 colls,     7 par    0.036s   0.012s     0.0015s    0.0037s

  Parallel GC work balance: 24.52% (serial 0%, perfect 100%)

  TASKS: 10 (1 bound, 9 peak workers (9 total), using -N4)

  SPARKS: 10336 (8199 converted, 2137 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.002s  (  0.001s elapsed)
  MUT     time    7.935s  (  3.928s elapsed)
  GC      time    4.172s  (  0.134s elapsed)
  EXIT    time    0.001s  (  0.008s elapsed)
  Total   time   12.110s  (  4.071s elapsed)

  Alloc rate    734,882,398 bytes per MUT second

  Productivity  65.5% of total user, 96.5% of total elapsed
```

rsa2

```
$ stack exec -- rsa2 encrypt /usr/share/dict/words +RTS -N4 -s >/dev/null
Stack has not been tested with GHC versions above 8.6, and using 8.8.2, this may fail
Stack has not been tested with Cabal versions above 2.4, but version 3.0.1.0 was found, this may fail
   5,964,293,608 bytes allocated in the heap
       9,777,288 bytes copied during GC
         313,128 bytes maximum residency (15 sample(s))
          71,896 bytes maximum slop
               0 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      1443 colls,  1443 par    4.294s   0.049s     0.0000s    0.0027s
  Gen  1        15 colls,    14 par    0.063s   0.002s     0.0001s    0.0002s

  Parallel GC work balance: 50.25% (serial 0%, perfect 100%)

  TASKS: 10 (1 bound, 9 peak workers (9 total), using -N4)

  SPARKS: 10336 (10335 converted, 0 overflowed, 0 dud, 0 GC'd, 1 fizzled)

  INIT    time    0.002s  (  0.001s elapsed)
  MUT     time    8.515s  (  3.198s elapsed)
  GC      time    4.357s  (  0.051s elapsed)
  EXIT    time    0.000s  (  0.000s elapsed)
  Total   time   12.874s  (  3.251s elapsed)

  Alloc rate    700,416,237 bytes per MUT second

  Productivity  66.1% of total user, 98.4% of total elapsed
```
# ベンチマークまとめ

env | version
----|----------
OS | Ubuntu 18.04
stack | 2.3.1
cabal | 3.2.0.0
ghc | 8.8.3

## ch04

chapter |     app      |     options    |          cabal           |          stack           | command | note
--------|--------------|----------------|:------------------------:|:------------------------:|---------|------
ch04    | fwsparse     | -O2            |   16.635s <br>( 16.640s ) | 16.578s <br>( 16.592s )
ch04    | fwsparse1    | -O2            |    5.818s <br>(  5.860s ) |  5.901s <br>(  5.930s )
ch04    | fwsparse1    | -O2 -N4        |    7.076s <br>(  1.891s ) |  6.866s <br>(  1.841s )
ch04    | timetable    | -O2            |    0.779s <br>(  0.791s ) |  0.788s <br>(  0.803s )
ch04    | timetable1   | -O2            |    0.790s <br>(  0.790s ) |  0.803s <br>(  0.807s )
ch04    | timetable2   | -O2            |    3.069s <br>(  3.121s ) |  2.976s <br>(  3.020s )
ch04    | timetable2   | -O2 -N4        |    4.301s <br>(  1.181s ) |  4.376s <br>(  1.191s )
ch04    | timetable3   | -O2            |    0.922s <br>(  0.940s ) |  0.939s <br>(  0.970s )
ch04    | timetable3   | -O2 -N4        |    0.997s <br>(  0.271s ) |  1.101s <br>(  0.291s )
ch04    | parinfer     | -O2            |    1.982s <br>(  1.990s ) |  1.982s <br>(  1.980s )
ch04    | parinfer     | -O2 -N2        |    2.013s <br>(  1.020s ) |  2.014s <br>(  1.020s )
ch04    | parinfer     | -O2 -N3        |    2.084s <br>(  1.021s ) |  2.100s <br>(  1.041s )
ch04    | parinfer     | -O2 -N4        |    2.075s <br>(  0.551s ) |  2.031s <br>(  0.531s )

## ch05

chapter |     app      |     options    |          cabal           |          stack           | command | note
--------|--------------|----------------|:------------------------:|:------------------------:|---------|------
ch05    | fwdense      | -O2            |   2.678s <br>(  2.687s ) |   2.713s <br>(  2.719s )
ch05    | fwdense      | -O2 -fllvm     |   1.456s <br>(  1.477s ) |   2.657s <br>(  2.665s )
ch05    | fwdense1     | -O2            |   3.069s <br>(  3.080s ) |   3.097s <br>(  3.110s )
ch05    | fwdense1     | -O2 -N4        |   3.224s <br>(  0.930s ) |   3.348s <br>(  0.951s )
ch05    | fwdense1     | -O2 -fllvm     |   1.721s <br>(  1.740s ) |   3.061s <br>(  3.090s )
ch05    | fwdense1     | -O2 -fllvm -N4 |   1.967s <br>(  0.631s ) |   3.269s <br>(  0.920s )
ch05    | rotaateimage | -O2            |   0.311s <br>(  0.320s ) |   0.298s <br>(  0.310s )
ch05    | rotaateimage | -O2 -N4        |   0.458s <br>(  0.140s ) |   0.429s <br>(  0.121s )

## ch06 

chapter |     app      |     options    |          cabal           |          stack           | command | note
--------|--------------|----------------|:------------------------:|:------------------------:|---------|------
ch06    | fwaccel-gpu  | -O2            |   1.642s <br>(  2.060s ) |   1.731s <br>(  2.040s )
ch06    | fwdense1     | -O2 -N7        | 187.260s <br>( 37.251s ) | 296.147s <br>( 53.181s )
ch06    | mandel       | -O2            |                          |  25.348s <br>( 26.690s )
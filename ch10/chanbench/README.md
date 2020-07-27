# chanbench

Total Time

command | Chan | TChan | TQueue | TBQUEUE
--------|------|-------|--------|---------
`chanbench 0 2000000` | 0.338s  (  0.371s elapsed) | 0.537s  (  0.733s elapsed) | 0.375s  (  0.430s elapsed) | 0.307s  (  0.326s elapsed)
`chanbench 1 2000000` | 0.449s  (  0.545s elapsed) | 0.475s  (  0.548s elapsed) | 0.412s  (  0.490s elapsed) | 失敗
`chanbench 2 2000000` | 0.190s  (  0.214s elapsed) | 0.188s  (  0.201s elapsed) | 0.193s  (  0.207s elapsed) | 0.308s  (  0.332s elapsed)

---

command | Chan | TChan | TQueue | TBQUEUE
--------|------|-------|--------|---------
`time chanbench 0 2000000` | 0.32 real<br>0.29 user<br> 0.01 sys | 0.95 real<br>0.48 user<br> 0.02 sys | 1.20 real<br>0.40 user<br> 0.01 sys
`time chanbench 1 2000000` | 0.57 real<br>0.46 user<br> 0.10 sys | 0.70 real<br>0.58 user<br> 0.08 sys | 0.51 real<br>0.42 user<br> 0.06 sys
`time chanbench 2 2000000` | 0.21 real<br>0.18 user<br> 0.00 sys | 0.27 real<br>0.25 user<br> 0.00 sys | 0.16 real<br>0.14 user<br> 0.00 sys
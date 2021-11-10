
\Begin SetMaxClock.f
\Get Max clock processor

30 MBMP ! 
0 MBMP 4 + !
GMCR MBMP 8 + ! 
8 MBMP C + ! 
0 MBMP 10 + ! 
3 MBMP 14 + ! 
18 30 STORE0
MBME VMBW !
\Set max clock processor

0 MBMP 4 + !
SCR MBMP 8 + ! 
C MBMP C + ! 
10 1C STORE0

MBME VMBW !
DROPMB
\end SetMaxClock.f

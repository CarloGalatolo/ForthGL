
\begin tilememalloc

4000 TILEMEM !

30 MBMP ! 
0 MBMP 4 + !
AMEM MBMP 8 + ! 
C MBMP C + ! 
0 MBMP 10 + ! 
8000 MBMP 14 + ! 
1000 mbmp 18 + !
18 mbmp 1C + !
20 30 STORE0

MBME VMBW !

MBMP 14 + @ TILEH !


30 MBMP ! 
0 MBMP 4 + !
LMEM MBMP 8 + ! 
4 MBMP C + ! 
0 MBMP 10 + ! 
TILEH @ MBMP 14 + ! 
18 30 STORE0

MBME VMBW !
MBMP 14 + @ DUP TILES !
4000 + TILEB !
DROPMB

\end tilealloc.f

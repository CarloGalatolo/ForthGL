
\begin binalloc.f

30 MBMP ! 
0 MBMP 4 + !
AMEM MBMP 8 + ! 
C MBMP C + ! 
0 MBMP 10 + ! 
10000 MBMP 14 + ! 
1000 mbmp 18 + !
18 mbmp 1C + !
20 30 STORE0

MBME VMBW !
MBMP 14 + @ BINH !

30 MBMP ! 
0 MBMP 4 + !
LMEM MBMP 8 + ! 
4 MBMP C + ! 
0 MBMP 10 + ! 
BINH @ MBMP 14 + ! 
18 30 STORE0

MBME VMBW !
MBMP 14 + @ BIND !
DROPMB
\end binalloc

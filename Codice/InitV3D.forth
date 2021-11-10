
\begin initV3d.F, by setting the qpu clock rate and enabling it

30 MBMP ! 
0 MBMP 4 + !
SCR MBMP 8 + ! 
8 MBMP C + ! 
0 MBMP 10 + ! 
5 MBMP 14 + ! 
EE6B280 mbmp 18 + !
0 mbmp 1C + !
20 30 STORE0

MBME VMBW !

0 MBMP 4 + !
EGPU MBMP 8 + ! 
4 MBMP C + ! 
0 MBMP 10 + ! 
1 MBMP 14 + ! 
18 20 STORE0
mbme vmbw !
DROPMB

\end initv3d.f

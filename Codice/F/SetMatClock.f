

HEX
10000000 CONSTANT MBMP 
00030004 CONSTANT GMCR
00038002 CONSTANT SCR
10000008 CONSTANT MBME 
3F00B8A0 CONSTANT VMBW
3FC00000 CONSTANT VC4P

30 MBMP ! 
0 MBMP 4 + !
GMCR MBMP 8 + ! 
8 MBMP C + ! 
0 MBMP 10 + ! 
3 MBMP 14 + ! 
0 mbmp 18 + !
0 mbmp 1C + !
0 mbmp 20 + !
0 mbmp 24 + !
0 mbmp 28 + !
0 mbmp 2C + !
0 mbmp 30 + !


MBME VMBW !

0 MBMP 4 + !
SCR MBMP 8 + ! 
C MBMP C + ! 
0 MBMP 10 + ! 
0 mbmp 1C + !

\3FC00000 @ .S

HEX
10000000 CONSTANT MBMP 
10000008 CONSTANT MBME 
3F00B8A0 CONSTANT VMBW
3000C CONSTANT ALLMEM
3000D CONSTANT LOCKMEM
10001000 CONSTANT RENDH

30 MBMP ! 
0 MBMP 4 + !
ALLMEM MBMP 8 + ! 
C MBMP C + ! 
0 MBMP 10 + ! 
10000 MBMP 14 + ! 
1000 mbmp 18 + !
18 1C + !
0 mbmp 20 + !
0 mbmp 24 + !
0 mbmp 28 + !
0 mbmp 2C + !
0 mbmp 30 + !

MBME VMBW !
MBMP 14 + @ RENDH !

\ADD A WAIT HERE MEMLOCK NEXT

30 MBMP ! 
0 MBMP 4 + !
LOCKMEM MBMP 8 + ! 
4 MBMP C + ! 
0 MBMP 10 + ! 
RENDH @ MBMP 14 + ! 
0 mbmp 18 + !
0 1C + !
0 mbmp 20 + !
0 mbmp 24 + !
0 mbmp 28 + !
0 mbmp 2C + !
0 mbmp 30 + !

\MBME VMBW ! 
\MBMP 14 + @ 10001004 !
\MBMP 14 + @ 10001008 !


.s

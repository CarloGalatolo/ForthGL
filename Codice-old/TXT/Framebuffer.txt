
/questo codice è l'associato del PiConsole_Init; ignorando la fase di settaggio poichè già data dal professore, e recuperando soltanto le dimensioni associate al framebuffer associato, con informazone del depth e del pitch


HEX
00040003 CONSTANT GPWH
00040004 CONSTANT GVWH
00040005 CONSTANT GDPH
00040008 CONSTANT GPTH
10000000 CONSTANT MBMP 
10000008 CONSTANT MBME 
3F00B8A0 CONSTANT VMBW

60 MBMP ! 
0 MBMP 4 + ! 
GPWH MBMP 8 + ! 
8 MBMP C + ! 
0 MBMP 10 + ! 
0 MBMP 14 + ! 
0 mbmp 18 + !
GVWH MBMP 1C + ! 
8 MBMP 20 + ! 
0 MBMP 24 + ! 
0 MBMP 28 + ! 
0 MBMP 2C + ! 
GDPH MBMP 30 + ! 
8 MBMP 34 + ! 
0 MBMP 38 + ! 
0 MBMP 3C + ! 
GPTH MBMP 40 + ! 
8 MBMP 44 + !
0 MBMP 48 + !
0 MBMP 4C + !
0 MBMP 50 + !
0 MBMP 54 + !
0 MBMP 58 + !
0 MBMP 5C + !
0 MBMP 60 + !


MBME VMBW !

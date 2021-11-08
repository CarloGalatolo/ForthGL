
variable BINF 

BIND @ 7f + ffffff80 AND DUP SHADER ! 
BIND @ SETPQ

70 TILEB @ 8 Lshift or EMIT
TILEB @ 18 Rshift TILEMEM @ 8 Lshift or EMIT
TILEMEM @ 18 Rshift TILES @  8 Lshift or EMIT
TILES @  18 Rshift BWH @ 8 lshift BHT @ 10 lshift 4 18 lshift or or or EMIT 

6 38 8 lshift 32 10 lshift 66 18 lshift or or or EMIT 
0 EMIT 
RWH @ RSV2 RHT @ RSV2 10 lshift or EMIT 

60 3 8 lshift 0 10 lshift 2 18 lshift  or or or EMIT 
67  EMIT 
41 8 lshift RSHADER @ 10 LSHIFT or EMIT 
RSHADER @ 10 RSHIFT 20 10 lshift 4 18 LSHIFT or or EMIT 
VVC4 @  EMIT 
IVVC4 @  EMIT 
MVC4 @  EMIT
05010000 RSV EMIT

P @ Q @ - BIND @ + BINF !

P @ 1 - P !

P @ Q @ 2DUP -
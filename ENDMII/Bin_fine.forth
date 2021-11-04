
variable BINF

BIND @ 7f + ffffff80 AND DUP SHADER ! 
BIND @ SETPQ

70 18 lshift TILEB @ 8 Rshift or EMIT
TILEB @ 18 lshift TILEMEM @ 8 Rshift or EMIT
TILEMEM @ 18 lshift TILES @ 8 Rshift or EMIT
TILES @ 18 lshift BWH @ 10 lshift BHT @ 8 lshift 4 or or or EMIT 

6 18 lshift 38 10 lshift 32 8 lshift 66 or or or EMIT 
0 EMIT 
RWH 10 lshift RHT or EMIT 

60 18 lshift 3 10 lshift 0 8 lshift 2 or or or EMIT 
67 18 lshift EMIT 
41 10 lshift RSHADER @ 10 RSHIFT or EMIT 
RSHADER @ 10 LSHIFT 20  8 lshift 4 or or EMIT 
VVC4 @ EMIT 
IVVC4 @ EMIT 
MVC4 @ EMIT
05010000  EMIT

P @ Q @ - BIND @ + BINF !


variable BINF 

BIND @ 7f + ffffff80 AND DUP SHADER ! 
BIND @ SETPQ

70 TILEB @ RSV 8 Lshift or EMITWORD
TILEB @ RSV 18 Rshift TILEMEM @ RSV 8 Lshift or EMITWORD
TILEMEM @ RSV 18 Rshift TILES @ RSV 8 Lshift or EMITWORD
TILES @ RSV 18 Rshift BWH @ 8 lshift BHT @ 10 lshift 4 18 lshift or or or EMITWORD 

6 38 8 lshift 32 10 lshift 66 18 lshift or or or EMITWORD 
0 EMITWORD 
RWH @ RSV2 RHT @ RSV2 10 lshift or EMITWORD 

60 3 8 lshift 0 10 lshift 2 18 lshift  or or or EMITWORD 
67  EMITWORD 
41 8 lshift RSHADER @ RSV 10 LSHIFT or EMITWORD 
RSHADER @ RSV 10 RSHIFT 20 10 lshift 4 18 LSHIFT or or EMITWORD 
VVC4 @ RSV EMITWORD 
IVVC4 @ RSV EMITWORD 
MVC4 @ RSV EMITWORD
05010000 RSV EMITWORD

P @ Q @ - BIND @ + BINF !

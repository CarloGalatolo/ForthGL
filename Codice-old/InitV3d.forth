/ abilita e setta il clock rate della gpu, controllando che il v3d venga inizializzato correttamente, viene eseguito dopo il setup del clock del processore ARM per delle operazioni che effettua di suo.

HEX
10000000 CONSTANT MBMP 
00030004 CONSTANT GMCR
00038002 CONSTANT SCR
10000008 CONSTANT MBME 
3F00B8A0 CONSTANT VMBW
30012 CONSTANT EGPU
3F000000 CONSTANT RPIOA
C00000 CONSTANT RPV3DA

30 MBMP ! 
0 MBMP 4 + !
SCR MBMP 8 + ! 
8 MBMP C + ! 
0 MBMP 10 + ! 
5 MBMP 14 + ! 
EE6B280 mbmp 18 + !
0 mbmp 1C + !
EGPU mbmp 20 + !
4 mbmp 24 + !
0 mbmp 28 + !
1 mbmp 2C + !
0 mbmp 30 + !

MBME VMBW !
RPIOA RPV3DA + @ 02443356 = 
.s

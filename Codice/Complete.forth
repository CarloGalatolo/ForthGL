 HEX 10000000 CONSTANT MBMP 10000008 CONSTANT MBME 3F00B8A0 CONSTANT VMBW 3FC00000 CONSTANT VC4P VARIABLE RENDH VARIABLE RENDD VARIABLE RENDL VARIABLE RWH	VARIABLE RHT	VARIABLE TILEH VARIABLE TILES VARIABLE TILEB VARIABLE TILEMEM VARIABLE BINH VARIABLE BIND VARIABLE BWH VARIABLE BHT 3000C CONSTANT AMEM	3000D CONSTANT LMEM	30010 CONSTANT EMEM 30012 CONSTANT EGPU	30004 CONSTANT GMCR	38002 CONSTANT SCR 40003 CONSTANT GPWH	40004 CONSTANT GVWH	40005 CONSTANT GDPH	40008 CONSTANT GPTH : STORE0 4 + SWAP BEGIN DUP MBMP + 0 SWAP ! 4 + 2DUP = UNTIL 2DROP ; : RSV DUP FF000000 AND 18 RSHIFT SWAP DUP 00FF0000 AND 8 RSHIFT SWAP DUP 0000FF00 AND 8 LSHIFT SWAP FF AND 18 LSHIFT OR OR OR ; : RSV2 DUP FF00 AND 8 RSHIFT SWAP FF AND 8 LSHIFT OR ; : DROPMB VMBW 20 - @ DROP ;  60 MBMP ! 0 MBMP 4 + ! GPWH MBMP 8 + ! 8 MBMP C + ! 10 18 STORE0 GVWH MBMP 1C + ! 8 MBMP 20 + ! 24 2C STORE0 GDPH MBMP 30 + ! 4 MBMP 34 + ! 38 3C STORE0 GPTH MBMP 40 + ! 4 MBMP 44 + ! 48 60 STORE0 MBME VMBW ! MBMP 14 + @ RWH ! MBMP 18 + @ RHT ! RHT @ 3f + 40 / BHT ! RWH @ 3f + 40 / BWH ! DROPMB  30 MBMP ! 0 MBMP 4 + ! GMCR MBMP 8 + ! 8 MBMP C + ! 0 MBMP 10 + ! 3 MBMP 14 + ! 18 30 STORE0 MBME VMBW ! 0 MBMP 4 + ! SCR MBMP 8 + ! C MBMP C + ! 10 1C STORE0 MBME VMBW ! DROPMB  30 MBMP ! 0 MBMP 4 + ! SCR MBMP 8 + ! 8 MBMP C + ! 0 MBMP 10 + ! 5 MBMP 14 + ! EE6B280 mbmp 18 + ! 0 mbmp 1C + ! 20 30 STORE0 MBME VMBW ! 0 MBMP 4 + ! EGPU MBMP 8 + ! 4 MBMP C + ! 0 MBMP 10 + ! 1 MBMP 14 + ! 18 20 STORE0 mbme vmbw ! DROPMB  4000 TILEMEM ! 30 MBMP ! 0 MBMP 4 + ! AMEM MBMP 8 + ! C MBMP C + ! 0 MBMP 10 + ! 8000 MBMP 14 + ! 1000 mbmp 18 + ! 18 mbmp 1C + ! 20 30 STORE0 MBME VMBW ! MBMP 14 + @ TILEH ! 30 MBMP ! 0 MBMP 4 + ! LMEM MBMP 8 + ! 4 MBMP C + ! 0 MBMP 10 + ! TILEH @ MBMP 14 + ! 18 30 STORE0 MBME VMBW ! MBMP 14 + @ DUP TILES ! 4000 + TILEB ! DROPMB  30 MBMP ! 0 MBMP 4 + ! AMEM MBMP 8 + ! C MBMP C + ! 0 MBMP 10 + ! 10000 MBMP 14 + ! 1000 mbmp 18 + ! 18 mbmp 1C + ! 20 30 STORE0 MBME VMBW ! MBMP 14 + @ BINH ! 30 MBMP ! 0 MBMP 4 + ! LMEM MBMP 8 + ! 4 MBMP C + ! 0 MBMP 10 + ! BINH @ MBMP 14 + ! 18 30 STORE0 MBME VMBW ! MBMP 14 + @ BIND ! DROPMB  30 MBMP ! 0 MBMP 4 + ! AMEM MBMP 8 + ! C MBMP C + ! 0 MBMP 10 + ! 10000 MBMP 14 + ! 1000 mbmp 18 + ! 18 1C mbmp + ! 20 30 STORE0 MBME VMBW ! MBMP 14 + @ RENDH ! 30 MBMP ! 0 MBMP 4 + ! LMEM MBMP 8 + ! 4 MBMP C + ! 0 MBMP 10 + ! RENDH @ MBMP 14 + ! 18 30 STORE0 MBME VMBW ! MBMP 14 + @ RENDD ! MBMP 14 + @ RENDL ! DROPMB  VARIABLE P VARIABLE PBUF VARIABLE COUNTER 0 COUNTER ! : EMITWORD DUP . P @ DUP . ! P @ DUP @ . 4 + P ! ; : EMIT8 COUNTER @ 0 = IF 0 OR PBUF ! ELSE PBUF @ 8 LSHIFT OR PBUF ! THEN COUNTER @ 1 + 4 MOD COUNTER ! COUNTER @ 0 = IF PBUF @ EMITWORD THEN ; : EMIT16 EMIT8 EMIT8 ; : EMIT32 EMIT8 EMIT8 EMIT8 EMIT8 ; variable NVRT variable VVC4 variable MVC4 variable IVVC4 variable Q : ARM2GPU C0000000 OR ; : GPU2ARM 3FFFFFFF AND ; : SET_LOADPOS RENDL @ 7f + ffffff80 AND ; 
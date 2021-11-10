\memory address
HEX
10000000 CONSTANT MBMP \Mailbox message pointer
10000008 CONSTANT MBME \Mailbox message execute
3F00B8A0 CONSTANT VMBW \Videocore Mailbox Write 
3FC00000 CONSTANT VC4P \Videocore 4 V3C Memory Pointer 

\resource memory address
 VARIABLE RENDH \Renderer Header
 VARIABLE RENDD \Renderer data handler
 VARIABLE RENDL \Renderer data load position
 VARIABLE RWH	\Renderer width
 VARIABLE RHT	\renderer height

 VARIABLE TILEH \Tile handler
 VARIABLE TILES \tile state data
 VARIABLE TILEB \tile data buffer
 VARIABLE TILEMEM \ tile size memory

 VARIABLE BINH \Bin Header
 VARIABLE BIND \Bin Datavc4

 VARIABLE BWH  \bin widht
 VARIABLE BHT \bin height
\mailbox tags

3000C CONSTANT AMEM	\Allocate Memory
3000D CONSTANT LMEM	\Lock memory   
30010 CONSTANT EMEM     \Execute Code (maybe useless)
30012 CONSTANT EGPU	\Enable GPU (Or QPU)

30004 CONSTANT GMCR	\Get Max Clock Rate
38002 CONSTANT SCR 	\Set Clock Rate

40003 CONSTANT GPWH	\Get phisical width/height
40004 CONSTANT GVWH	\Get Virtual width/height
40005 CONSTANT GDPH	\Get Depth
40008 CONSTANT GPTH     \Get Pitch

\ ( begin end -- )
\ Memorizza 0 in MBMP a partire da offset +begin a finire con offset +end incluso.
: STORE0  4 + SWAP BEGIN DUP MBMP + 0 SWAP ! 4 + 2DUP = UNTIL 2DROP ;

: RSV  DUP FF000000 AND 18 RSHIFT SWAP DUP 00FF0000 AND 8 RSHIFT SWAP DUP 0000FF00 AND 8 LSHIFT SWAP FF AND 18 LSHIFT OR OR OR ;

: RSV2  DUP FF00 AND 8 RSHIFT SWAP FF AND 8 LSHIFT OR ;

: DROPMB  VMBW 20 - @ DROP ;

\ vmbw 20 - dup @ . dup 14 + @ .
 
\ dup @ . dup 14 + @ .
\ dup @ . dup 14 + @ .

\ps. la mailbox può saturarsi, ricordare di smontare valori leggendo il valore nell'indirizzo videocore 3f00b880, e scartando il valore con .

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

: RSV DUP FF000000 AND 18 RSHIFT SWAP DUP 00FF0000 AND 8 RSHIFT SWAP DUP 0000FF00 AND 8 LSHIFT SWAP FF AND 18 LSHIFT OR OR OR ;

: RSV2 DUP FF00 AND 8 RSHIFT SWAP FF AND 8 LSHIFT OR ;
\Framebuffer.f get dimension of the framebuffer

60 MBMP ! 
0 MBMP 4 + ! 
GPWH MBMP 8 + ! 
8 MBMP C + ! 
10 18 STORE0
GVWH MBMP 1C + ! 
8 MBMP 20 + ! 
24 2C STORE0
GDPH MBMP 30 + ! 
4 MBMP 34 + ! 
38 3C STORE0
GPTH MBMP 40 + ! 
4 MBMP 44 + !
48 60 STORE0


MBME VMBW !
MBMP 14 + @ RWH !
MBMP 18 + @ RHT !
RHT @ 3f + 40 / BHT !
RWH @ 3f + 40 / BWH !

\end Framebuffer.f

\Begin SetMaxClock.f
\Get Max clock processor
30 MBMP ! 
0 MBMP 4 + !
GMCR MBMP 8 + ! 
8 MBMP C + ! 
0 MBMP 10 + ! 
3 MBMP 14 + ! 
18 30 STORE0
MBME VMBW !
\Set max clock processor

0 MBMP 4 + !
SCR MBMP 8 + ! 
C MBMP C + ! 
10 1C STORE0

MBME VMBW !
\end SetMaxClock.f

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
\end initv3d.f

\begin tilememalloc

4000 TILEMEM !

30 MBMP ! 
0 MBMP 4 + !
AMEM MBMP 8 + ! 
C MBMP C + ! 
0 MBMP 10 + ! 
8000 MBMP 14 + ! 
1000 mbmp 18 + !
18 mbmp 1C + !
20 30 STORE0

MBME VMBW !

MBMP 14 + @ TILEH !


30 MBMP ! 
0 MBMP 4 + !
LMEM MBMP 8 + ! 
4 MBMP C + ! 
0 MBMP 10 + ! 
TILEH @ MBMP 14 + ! 
18 30 STORE0

MBME VMBW !
MBMP 14 + @ DUP TILES !
4000 + TILEB !

\end tilealloc.f
 vmbw 20 - dup @ . dup 14 + @ .
 
dup @ . dup 14 + @ .
dup @ . dup 14 + @ .

\ps. la mailbox può saturarsi, ricordare di smontare valori leggendo il valore nell'indirizzo videocore 3f00b880, e scartando il valore con .


\begin binalloc.f

30 MBMP ! 
0 MBMP 4 + !
AMEM MBMP 8 + ! 
C MBMP C + ! 
0 MBMP 10 + ! 
10000 MBMP 14 + ! 
1000 mbmp 18 + !
18 mbmp 1C + !
20 30 STORE0

MBME VMBW !
MBMP 14 + @ BINH !

30 MBMP ! 
0 MBMP 4 + !
LMEM MBMP 8 + ! 
4 MBMP C + ! 
0 MBMP 10 + ! 
BINH @ MBMP 14 + ! 
18 30 STORE0

MBME VMBW !
MBMP 14 + @ BIND !
\end binalloc

\begin V3Dmemalloc.f , TO BE MORE SPECIFIC: THIS IS THE RENDERER HANDLER
30 MBMP ! 
0 MBMP 4 + !
AMEM MBMP 8 + ! 
C MBMP C + ! 
0 MBMP 10 + ! 
10000 MBMP 14 + ! 
1000 mbmp 18 + !
18 1C mbmp + !
20 30 STORE0

MBME VMBW !
MBMP 14 + @ RENDH !

30 MBMP ! 
0 MBMP 4 + !
LMEM MBMP 8 + ! 
4 MBMP C + ! 
0 MBMP 10 + ! 
RENDH @ MBMP 14 + ! 
18 30 STORE0

MBME VMBW !
MBMP 14 + @ RENDD !
MBMP 14 + @ RENDL !

\end V3dMemalloc

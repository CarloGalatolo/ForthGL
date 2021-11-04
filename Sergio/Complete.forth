\ VERIFICARE CHE STORE0 FUNZIONI

\memory address
HEX
10000000 CONSTANT MBMP \Mailbox message pointer
10000008 CONSTANT MBME \Mailbox message execute
3F00B8A0 CONSTANT VMBW \Videocore Mailbox Write 
3FC00000 CONSTANT VC4P \Videocore 4 V3C Memory Pointer 

\resource memory address
10001000 CONSTANT RENDH \Renderer Header
10001004 CONSTANT RENDD \Renderer data handler
10001008 CONSTANT RENDL \Renderer data load position
1000100C CONSTANT RWH	\Renderer width
10001010 CONSTANT RHT	\renderer height

10002000 CONSTANT TILEH   \Tile handler
10002004 CONSTANT TILES   \Tile state data
10002008 CONSTANT TILEB   \Tile data buffer
1000200C CONSTANT TILEMEM \Tile size memory

10003000 CONSTANT BINH \Bin Header
10003004 CONSTANT BIND \Bin Datavc4

1000300C CONSTANT BWH \bin widht
10003010 CONSTANT BHT \bin height
\mailbox tags

3000C CONSTANT AMEM	\Allocate Memory
3000D CONSTANT LMEM	\Lock memory   
30010 CONSTANT EMEM \Execute Code (maybe useless)
30012 CONSTANT EGPU	\Enable GPU (Or QPU)

30004 CONSTANT GMCR	\Get Max Clock Rate
38002 CONSTANT SCR 	\Set Clock Rate

40003 CONSTANT GPWH	\Get phisical width/height
40004 CONSTANT GVWH	\Get Virtual width/height
40005 CONSTANT GDPH	\Get Depth
40008 CONSTANT GPTH \Get Pitch


\Framebuffer.f get dimension of the framebuffer

\ ( begin end -- )
\ Memorizza 0 in MBMP a partire da offset +begin a finire con offset +end incluso.
: STORE0  4 + SWAP BEGIN DUP MBMP + 0 SWAP ! 4 + 2DUP = UNTIL 2DROP ;

60 MBMP ! 
0 MBMP 4 + ! 
GPWH MBMP 8 + ! 
8 MBMP C + ! 
\0 MBMP 10 + ! 
\0 MBMP 14 + ! 
\0 mbmp 18 + !
10 18 STORE0
GVWH MBMP 1C + ! 
8 MBMP 20 + ! 
\0 MBMP 24 + ! 
\0 MBMP 28 + ! 
\0 MBMP 2C + ! 
24 2C STORE0
GDPH MBMP 30 + ! 
4 MBMP 34 + ! 
\0 MBMP 38 + ! 
\0 MBMP 3C + ! 
38 3C STORE0
GPTH MBMP 40 + ! 
4 MBMP 44 + !
\0 MBMP 48 + !
\0 MBMP 4C + !
\0 MBMP 50 + !
\0 MBMP 54 + !
\0 MBMP 58 + !
\0 MBMP 5C + !
\0 MBMP 60 + !
48 60 STORE0


MBME VMBW !
MBMP 14 + DUP @ RWH !
MBMP 18 + DUP @ RHT !
3f + 40 / BHT !
3f + 40 / BWH !

\end Framebuffer.f

\Begin SetMaxClock.f
\Get Max clock processor
30 MBMP ! 
0 MBMP 4 + !
GMCR MBMP 8 + ! 
8 MBMP C + ! 
0 MBMP 10 + ! 
3 MBMP 14 + ! 
\0 mbmp 18 + !
\0 mbmp 1C + !
\0 mbmp 20 + !
\0 mbmp 24 + !
\0 mbmp 28 + !
\0 mbmp 2C + !
\0 mbmp 30 + !
18 30 STORE0
MBME VMBW !
\Set max clock processor

0 MBMP 4 + !
SCR MBMP 8 + ! 
C MBMP C + ! 
\0 MBMP 10 + ! 
\0 mbmp 1C + !
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

MBME VMBW !

0 MBMP 4 + !
EGPU MBMP 8 + ! 
4 MBMP C + ! 
0 MBMP 10 + ! 
1 MBMP 14 + ! 
\0 MBMP 18 + ! 
\0 MBMP 1c + ! 
\0 MBMP 20 + ! 
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
\0 mbmp 20 + !
\0 mbmp 24 + !
\0 mbmp 28 + !
\0 mbmp 2C + !
\0 mbmp 30 + !
20 30 STORE0

MBME VMBW !

MBMP 14 + @ TILEH !


30 MBMP ! 
0 MBMP 4 + !
LMEM MBMP 8 + ! 
4 MBMP C + ! 
0 MBMP 10 + ! 
TILEH @ MBMP 14 + ! 
\0 mbmp 18 + !
\0 mbmp 1c + !
\0 mbmp 20 + !
\0 mbmp 24 + !
\0 mbmp 28 + !
\0 mbmp 2C + !
\0 mbmp 30 + !
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
\0 mbmp 20 + !
\0 mbmp 24 + !
\0 mbmp 28 + !
\0 mbmp 2C + !
\0 mbmp 30 + !
20 30 STORE0

MBME VMBW !
MBMP 14 + @ BINH !

30 MBMP ! 
0 MBMP 4 + !
LMEM MBMP 8 + ! 
4 MBMP C + ! 
0 MBMP 10 + ! 
BINH @ MBMP 14 + ! 
\0 mbmp 18 + !
\0 mbmp 1C + !
\0 mbmp 20 + !
\0 mbmp 24 + !
\0 mbmp 28 + !
\0 mbmp 2C + !
\0 mbmp 30 + !
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
\0 mbmp 20 + !
\0 mbmp 24 + !
\0 mbmp 28 + !
\0 mbmp 2C + !
\0 mbmp 30 + !
20 30 STORE0

MBME VMBW !
MBMP 14 + @ RENDH !

30 MBMP ! 
0 MBMP 4 + !
LMEM MBMP 8 + ! 
4 MBMP C + ! 
0 MBMP 10 + ! 
RENDH @ MBMP 14 + ! 
\0 mbmp 18 + !
\0 1C mbmp + !
\0 mbmp 20 + !
\0 mbmp 24 + !
\0 mbmp 28 + !
\0 mbmp 2C + !
\0 mbmp 30 + !
18 30 STORE0

MBME VMBW !
MBMP 14 + @ RENDD !
MBMP 14 + @ RENDL !

\end V3dMemalloc

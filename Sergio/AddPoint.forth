HEX
variable NVRT \number of vertex
variable VVC4 \Vertex VC4
variable MVC4 \Max Vertex VC4
variable IVVC4 \index Vertex VC4
\ variable P \P
variable Q \Q

\ Converte un indirizzo a 32 bit dal formato ARM al formato GPU.
: ARM2GPU   C0000000 OR ;    \ (ARMaddr -- GPUaddr)

\ Converte un indirizzo a 32 bit dal formato GPU al formato ARM.
: GPU2ARM   3FFFFFFF AND ;  \ (GPUaddr -- ARMaddr)

\ (uint32 -- )
\ Emit word on memory position P
\ : EMIT DUP . P @ DUP . ! P @ DUP @ . 4 + P ! ; 

\ (? -- ?)
\ scene->vertexVC4 = (scene->loadpos + 127) & ALIGN_128BIT_MASK;	// Hold vertex start adderss .. aligned to 128bits
: SET_LOADPOS  RENDL @ 7f + ffffff80 AND ; 

\ (? -- ?)
: UPDATE_LOADPOS   P @ Q @ - SET_LOADPOS + RENDL ! ;

\ scene->tmp[0] = scene->vertexVC4;
\ uint8_t* p = (uint8_t*)(uintptr_t)GPUaddrToARMaddr(scene->vertexVC4);
\ uint8_t* q = p;
: SETPQ  GPU2ARM DUP P ! DUP Q ! ;

SET_LOADPOS 
SETPQ

\RWH @ 2 /    \ CentreX
\RHT @ 2 / 4 * A / 	\CentreY
\RWH @ 2 / 4 * A /	\Half-shape WHT
\RHT @ 2 / 3 * A /	\Half-shape HT

\RWH @ 2 / 14 lshift RHT @ 2 / 4 * A / RHT @ 2 / 3 * A / - 4 lshift OR EMIT

0 EMITWORD \ VERTICE 1

3F 80 00 00 EMIT32
3F 80 00 00 EMIT32
3F 80 00 00 EMIT32
0 EMITWORD
0 EMITWORD

\RWH @ 2 / RWH @ 2 / 4 * A / - 14 lshift
\RHT @ 2 / 4 * A / RHT @ 2 / 3 * A / + 4 lshift
\OR EMIT

02 00 00 00 EMIT32 \ VERTICE 2
3F 80 00 00 EMIT32
3F 80 00 00 EMIT32
0 EMITWORD
0 EMITWORD
3F 80 00 00 EMIT32

\ RWH @ 2 / RWH @ 2 / 4 * A / + 14 lshift
\ RHT @ 2 / 4 * A / RHT @ 2 / 3 * A / + 4 lshift
\ OR EMIT

02 00 02 00 RSV2 EMIT32 \ VERTICE 3
3F 80 00 00 EMIT32
3F 80 00 00 EMIT32
0 EMITWORD
3F 80 00 00 EMIT32
0 EMITWORD

3 NVRT !
UPDATE_LOADPOS

SET_LOADPOS DUP IVVC4 !
SETPQ

00 02 01 00  EMIT32

3 VVC4 !
2 MVC4 !
P @ 1 - P ! 
UPDATE_LOADPOS

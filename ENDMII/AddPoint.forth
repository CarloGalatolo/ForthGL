HEX
variable NVRT \number of vertex
variable VVC4 \Vertex VC4
variable MVC4 \Max Vertex VC4
variable IVVC4 \index Vertex VC4
variable P \P
variable Q \Q

\ Converte un indirizzo a 32 bit dal formato ARM al formato GPU.
: ARM2GPU   C0000000 OR ;    \ (ARMaddr -- GPUaddr)

\ Converte un indirizzo a 32 bit dal formato GPU al formato ARM.
: GPU2ARM   3FFFFFFF AND ;  \ (GPUaddr -- ARMaddr)

\ (uint32 -- )
\ Emit word on memory position P
: EMIT  P @ ! P @ 4 + P ! ; 

\ (? -- ?)
\ scene->vertexVC4 = (scene->loadpos + 127) & ALIGN_128BIT_MASK;	// Hold vertex start adderss .. aligned to 128bits
: SET_LOADPOS   RENDL @ 7f + ffffff80 AND ; 

\ (? -- ?)
: UPDATE_LOADPOS   P @ Q @ - SET_LOADPOS + RENDL ! ;

\ scene->tmp[0] = scene->vertexVC4;
\ uint8_t* p = (uint8_t*)(uintptr_t)GPUaddrToARMaddr(scene->vertexVC4);
\ uint8_t* q = p;
: SETPQ  GPU2ARM DUP P ! DUP Q ! ;

SET_LOADPOS 
SETPQ

RWH @ 2 /    \ CentreX
RHT @ 2 / 4 * A / 	\CentreY
RWH @ 2 / 4 * A /	\Half-shape WHT
RHT @ 2 / 3 * A /	\Half-shape HT

RWH @ 2 / 14 lshift RHT @ 2 / 4 * A / RHT @ 2 / 3 * A / - 4 lshift OR EMIT


3F800000 EMIT
3F800000 EMIT
3F800000 EMIT
0 EMIT
0 EMIT

RWH @ 2 / RWH @ 2 / 4 * A / - 14 lshift
RHT @ 2 / 4 * A / RHT @ 2 / 3 * A / + 4 lshift
OR EMIT

3F800000 EMIT
3F800000 EMIT
0 EMIT
0 EMIT
3F800000 EMIT

RWH @ 2 / RWH @ 2 / 4 * A / + 14 lshift
RHT @ 2 / 4 * A / RHT @ 2 / 3 * A / + 4 lshift
OR EMIT


3F800000 EMIT
3F800000 EMIT
0 EMIT
3F800000 EMIT
0 EMIT

3 NVRT !
UPDATE_LOADPOS

SET_LOADPOS DUP IVVC4 !
SETPQ

1 lshift 8 2 or
EMIT

3 VVC4 !
3 MVC4 !

UPDATE_LOADPOS

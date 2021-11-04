variable X 
variable Y
variable BUF
variable CONT
variable ENDREND
variable RENDCONT
variable SHADER \Q

variable P \P
variable Q \Q

\ Converte un indirizzo a 32 bit dal formato ARM al formato GPU.
: ARM2GPU   C0000000 OR ;    \ (ARMaddr -- GPUaddr)

\ Converte un indirizzo a 32 bit dal formato GPU al formato ARM.
: GPU2ARM   3FFFFFFF AND ;  \ (GPUaddr -- ARMaddr)

\ (uint32 -- )
\ Emit word on memory position P
: EMITWORD  P @ ! P @ 4 + P ! ; 

\ (? -- ?)
\ scene->vertexVC4 = (scene->loadpos + 127) & ALIGN_128BIT_MASK;	// Hold vertex start adderss .. aligned to 128bits
: SET_LOADPOS   RENDL @ 7f + ffffff80 AND ; 

\ (? -- ?)
: UPDATE_LOADPOS   P @ Q @ - SET_LOADPOS + RENDL ! ;

\ scene->tmp[0] = scene->vertexVC4;
\ uint8_t* p = (uint8_t*)(uintptr_t)GPUaddrToARMaddr(scene->vertexVC4);
\ uint8_t* q = p;
: SETPQ  GPU2ARM DUP P ! DUP Q ! ;

SET_LOADPOS DUP RENDCONT ! 
SETPQ

72000000 EMITWORD
ff000000 EMITWORD
ff000000 EMITWORD
0000 EMITWORD

P @ Q @ - SHADER @ + DUP RENDL ! ENDREND !

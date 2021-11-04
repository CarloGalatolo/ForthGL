HEX

\0x958e0dbf, 0xd1724823,   /* mov r0, vary; mov r3.8d, 1.0 */
\0x818e7176, 0x40024821,   /* fadd r0, r0, r5; mov r1, vary */
\0x818e7376, 0x10024862,   /* fadd r1, r1, r5; mov r2, vary */
\0x819e7540, 0x114248a3,   /* fadd r2, r2, r5; mov r3.8a, r0 */
\0x809e7009, 0x115049e3,   /* nop; mov r3.8b, r1 */
\0x809e7012, 0x116049e3,   /* nop; mov r3.8c, r2 */
\0x159e76c0, 0x30020ba7,   /* mov tlbc, r3; nop; thrend */
\0x009e7000, 0x100009e7,   /* nop; nop; nop */
\0x009e7000, 0x500009e7,   /* nop; nop; sbdone */ 

variable SHADER \Q
variable RSHADER \ fragShaderRecStart record

SET_LOADPOS DUP SHADER ! 
SETPQ

958e0dbf EMIT
d1724823 EMIT
818e7176 EMIT
40024821 EMIT
818e7376 EMIT
10024862 EMIT
819e7540 EMIT
114248a3 EMIT
809e7009 EMIT
115049e3 EMIT
809e7012 EMIT
116049e3 EMIT
159e76c0 EMIT
30020ba7 EMIT
009e7000 EMIT
100009e7 EMIT
009e7000 EMIT
500009e7 EMIT

P @ Q @ - SET_LOADPOS + RENDL !

SET_LOADPOS DUP RSHADER !
SETPQ

01 18 lshift 6 4 * 10 lshift cc 8 lshift 3 or or or  
EMIT 
SHADER EMIT 
0 EMIT 
RENDD @ 7f + ffffff80 AND EMIT 

P @ Q @ - SET_LOADPOS + RENDL !

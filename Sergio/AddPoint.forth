HEX
10004000 constant NVRT \number of vertex
10004004 constant VVC4 \Vertex VC4
10004010 constant MVC4 \Max Vertex VC4
10004008 constant P    \P
1000400C constant Q    \Q

3F800000 constant f1.0 \ 1.0 Float number

SET_LOADPOS
SETPQ

RWH @ 2 /           \CentreX
RHT @ 2 / 4 * A / 	\CentreY
RWH @ 2 / 4 * A /	\Half-shape WHT
RHT @ 2 / 3 * A /	\Half-shape HT


RWH @ 2 / 14 lshift 
RHT @ 2 / 4 * A / RHT @ 2 / 3 * A / - 4 lshift 
OR

EMIT


f1.0 EMIT
f1.0 EMIT
f1.0 EMIT
0 EMIT
0 EMIT

RWH @ 2 / RWH @ 2 / 4 * A / - 14 lshift
RHT @ 2 / 4 * A / RHT @ 2 / 3 * A / + 4 lshift
OR EMIT

f1.0 EMIT
f1.0 EMIT
0 EMIT
0 EMIT
f1.0 EMIT

RWH @ 2 / RWH @ 2 / 4 * A / + 14 lshift
RHT @ 2 / 4 * A / RHT @ 2 / 3 * A / + 4 lshift
OR EMIT


f1.0 EMIT
f1.0 EMIT
0 EMIT
f1.0 EMIT
0 EMIT

3 NVRT !
UPDATE_LOADPOS

SET_LOADPOS
SETPQ

1 lshift 8 2 or
EMIT

3 VVC4 !
3 MVC4 !

UPDATE_LOADPOS



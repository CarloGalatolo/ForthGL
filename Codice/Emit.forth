
\HEX

VARIABLE P
VARIABLE PBUF
VARIABLE COUNTER
0 COUNTER !

\ (uint32 -- )
\ Emit word on memory position P
: EMITWORD  DUP . P @ DUP . ! P @ DUP @ . 4 + P ! ; 

\ Prende un byte in esadecimale e un counter da 0 a 3, costruisce una parola a 32 bit componendola 
\ 8 bit alla volta e shiftando se necessario.
\ (byte -- )
: EMIT8   COUNTER @ 0 = IF 0 OR PBUF ! ELSE PBUF @ 8 LSHIFT OR PBUF ! THEN 
          COUNTER @ 1 + 4 MOD COUNTER ! COUNTER @ 0 = IF PBUF @ EMITWORD THEN ;

\ (byte0 byte1 -- )
: EMIT16   EMIT8 EMIT8 ;

\ (byte0 byte1 byte2 byte3 -- )
: EMIT32   EMIT8 EMIT8 EMIT8 EMIT8 ;

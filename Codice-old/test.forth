\ Test per creare vettori ""dinamici"".
HEX

e12fff1e CONSTANT BX_LR
CREATE NOME

: TMP  E3A00003 , BX_LR , ;

: TEST  CREATE NOME TMP DROP ;   \ CREATE lascia un riferimento a qualcosa nello stack, quindi DROP.


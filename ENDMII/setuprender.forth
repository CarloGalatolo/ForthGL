variable X 
variable Y
variable BUF
variable CONT
variable ENDREND
variable RENDCONT

: ASS0 0 CONT ! X @ 18 LSHIFT Y @ 10 LSHIFT 11 8 LSHIFT TILEB @ Y @ BWH @ * X @ + 32 * + 18 RSHIFT OR EMIT 
	   TILEB @ Y @ BWH @ * X @ + 32 * + 8 LSHIFT
	   X @ BWH @ 1 - = Y @ BHT @ 1 - = AND IF 19 OR EMIT 0 BUF !  ELSE 18 OR EMIT 0 BUF ! ;
	 

: ASS1 1 CONT ! 73 18 LSHIFT X @ 10 LSHIFT Y @ 8 LSHIFT 11  OR OR OR EMIT  
	   TILEB @ Y @ BWH @ * X @ + 20 * +  EMIT 
	   X @ BWH @ 1 - = Y @ BHT @ 1 - = AND IF 19 BUF ! ELSE 18 BUF ! THEN ;

	     
: ASS2 2 CONT ! BUF @ 18 LSHIFT 73 10 LSHIFT X @ 8 LSHIFT Y @ OR OR OR EMIT 
	   11 18 LSHIFT TILEB @ Y @ BWH @ * X @ + 32 * + 8 RSHIFT OR EMIT 
	   TILEB @ Y @ BWH @ * X @ + 20 * + 18 LSHIFT 10 RSHIFT
	   X @ BWH @ 1 - = Y @ BHT @ 1 - = AND IF 19 OR BUF ! ELSE 18 OR BUF ! THEN ;


: ASS3 3 CONT ! BUF @ 10 LSHIFT 73 8 LSHIFT X @ OR OR EMIT 
	   Y @ 18 LSHIFT 11 10 LSHIFT TILEB @ Y @ BWH @ * X @ + 32 * + 10 RSHIFT OR OR EMIT  
	   TILEB @ Y @ BWH @ * X @ + 20 * + 10 LSHIFT 8 RSHIFT
	   X BWH @ 1 - = Y @ BHT @ 1 - = AND IF 19 OR BUF ! ELSE 18 OR BUF ! THEN ;

: ASS4 0 CONT ! BUF @ 8 LSHIFT 73 OR EMIT 
	   X @ 18 LSHIFT Y @ 10 LSHIFT 11 8 LSHIFT TILEB @ Y @ BWH @ * X @ + 32 * + 18 RSHIFT OR OR OR EMIT 
	   TILEB @ Y @ BWH @ * X @ + 32 * + 8 LSHIFT 
	   X @ BWH @ 1 - = Y @ BHT @ 1 - = AND IF 19 OR EMIT 0 BUF !  ELSE 18 OR EMIT 0 BUF ! THEN ;
	 
: CHKBUF3  2 = IF ASS3 ELSE ASS4 THEN ;
: CHKBUF2  DUP 1 = IF DROP ASS2 ELSE CHKBUF3 THEN ;
: CHKBUF   DUP 0 = IF DROP ASS1 ELSE CHKBUF2 THEN ;

: FINBUF3  2 = IF BUF @ 10 LSHIFT EMIT ELSE BUF @ 8 LSHIFT EMIT THEN ;
: FINBUF2  DUP 1 = IF DROP BUF @ 18 LSHIFT EMIT ELSE CHKBUF3 THEN ;
: FINBUF   DUP 0 = IF DROP ELSE FINBUF2 THEN ;

: LOOPY BEGIN CONT @ CHKBUF 1 + DUP Y ! DUP BHT @ = UNTIL  ;
: LOOPX X @ BEGIN Y @ LOOPY DROP 0 Y ! 1 + DUP X ! DUP BWH @ = UNTIL ;


SET_LOADPOS DUP RENDCONT ! 
SETPQ

72ff0000 EMIT
00ff0000 EMIT
00000000 EMIT
000071 8 LSHIFT FRAMEBUFFER @ 18 RSHIFT OR EMIT
FRAMEBUFFER 8 LSHIFT RWH 8 RSHIFT OR EMIT
RWH 18 LSHIFT RHT 8 LSHIFT 04 OR OR EMIT
00730000 EMIT
1C000000 EMIT
00000073 EMIT

0 X !
1 Y ! 
RWH @ 3f + 40 / BWH ! 
RHT @ 3f + 40 / BHT ! 
 
ASS0
LOOPX
BUF @ FINBUF

P @ Q @ - SHADER @ + DUP RENDL ! ENDREND !

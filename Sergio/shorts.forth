variable X 
variable Y
variable BUF
variable CONT
variable ENDREND
variable RENDCONT

2 BWH ! 
2 BHT !

: ASS0 0 CONT ! X @ Y @ 8 LSHIFT 11 10 LSHIFT TILEB @ Y @ BWH @ * X @ + 32 * + DUP . 18 LSHIFT OR OR OR EMIT 
	   TILEB @ Y @ BWH @ * X @ + 32 * + DUP . 8 RSHIFT
	  18 18 lshift OR EMIT 0 BUF ! THEN ;
	 

: ASS1 1 CONT ! 73 X @ 8 LSHIFT Y @ 10 LSHIFT 11 18 LSHIFT OR OR OR EMIT  
	   TILEB @ Y @ BWH @ * X @ + 20 * + EMIT 
	   X @ BWH @ 1 - = Y @ BHT @ 1 - = AND 1 = IF 1 . 19 BUF ! ELSE 18 BUF ! THEN ;

	     
: ASS2 2 CONT ! BUF @ 73 8 LSHIFT X @ 10 LSHIFT Y @ 18 LSHIFT OR OR OR EMIT 
	   11 TILEB @ Y @ BWH @ * X @ + 32 * +  8 LSHIFT OR EMIT 
	   TILEB @ Y @ BWH @ * X @ + 20 * +  18 RSHIFT
	   X @ BWH @ 1 - = Y @ BHT @ 1 - = AND 1 = IF 2 . 19 8 LSHIFT OR BUF ! ELSE 18 8 LSHIFT OR BUF ! THEN ;


: ASS3 3 CONT ! BUF @ 73 10 LSHIFT X @ 18 LSHIFT OR OR EMIT 
	   Y @ 11 8 LSHIFT TILEB @ Y @ BWH @ * X @ + 32 * +  10 LSHIFT OR OR EMIT  
	   TILEB @ Y @ BWH @ * X @ + 20 * +  10 RSHIFT 
	   X BWH @ 1 - = Y @ BHT @ 1 - = AND 1 = IF 3 . 19 10 LSHIFT OR BUF ! ELSE 18 10 LSHIFT  OR BUF ! THEN ;

: ASS4 0 CONT ! BUF @ 73 18 LSHIFT OR EMIT 
	   X @  Y @ 8 LSHIFT 11 10 LSHIFT TILEB @ Y @ BWH @ * X @ + 32 * +  18 LSHIFT OR OR OR EMIT 
	   TILEB @ Y @ BWH @ * X @ + 32 * +  8 RSHIFT 
	   X @ BWH @ 1 - = Y @ BHT @ 1 - = AND 1 = IF 4 . 19 18 LSHIFT OR EMIT 0 BUF !  ELSE 18 18 LSHIFT OR EMIT 0 BUF ! THEN ;
	 
: CHKBUF3  2 = IF ASS3 ELSE ASS4 THEN ;
: CHKBUF2  DUP 1 = IF DROP ASS2 ELSE CHKBUF3 THEN ;
: CHKBUF   DUP 0 = IF DROP ASS1 ELSE CHKBUF2 THEN ;

: FINBUF3  2 = IF BUF @ 19 8 LSHIFT OR EMIT ELSE BUF @ 19 10 LSHIFT OR EMIT THEN ;
: FINBUF2  DUP 1 = IF DROP BUF @ 19  OR EMIT ELSE CHKBUF3 THEN ;
: FINBUF  CONT @ DUP 0 = IF DROP ELSE FINBUF2 THEN ;

: LOOPY BEGIN CONT @ CHKBUF 1 + DUP Y ! DUP BHT @ => UNTIL  ;
: LOOPX X @ BEGIN Y @ LOOPY DROP 0 Y ! 1 + DUP X ! DUP BWH @ => UNTIL BUF @ EMIT ;

SET_LOADPOS DUP RENDCONT ! 
SETPQ

00000072 EMIT
000000ff EMIT
000000ff EMIT
00710000 FRAMEBUFFER @ RSV 18 LSHIFT OR EMIT
FRAMEBUFFER @ RSV 8 RSHIFT RWH @ RSV2 18 LSHIFT OR EMIT
RWH @  8 RSHIFT RHT @  8 LSHIFT 04 18 LSHIFT OR OR EMIT
00007300 EMIT
0000001C EMIT
73000000 EMIT

0 X !
0 Y !

ASS0
0 X !
1 Y ! 

\ RWH @ 3f + 40 / BWH ! 
\ RHT @ 3f + 40 / BHT ! 
  
\ P @ Q @ - SHADER @ + DUP RENDL ! ENDREND !

LOOPX
 
 


\ Utilità per la memorizzazione di half-word.

HEX

: !HL \ (h var -- ) Half-word Little Endian Store [15:0]
	SWAP FFFF AND SWAP ! ;
: @HL \ ( -- h) Half-word Little Endian Fetch
	@ FFFF AND ; 
: !HB \ (h var -- ) Half-word Big Endian Store [31:16]
	SWAP FFFF AND 10 LSHIFT SWAP ! ; 
: @HB \ ( -- h) Half-word Big Endian Fetch
	@ FFFF0000 AND ;
	
: !POINT \ (x y var -- )
	ROT FFFF AND 10 LSHIFT ROT FFFF AND + SWAP ! ;

\
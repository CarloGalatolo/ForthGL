\ Funzioni di conversione degli indirizzi da ARM a GPU e viceversa.

\ Importare "se-ans.f" prima.
HEX

e12fff1e CONSTANT BX_LR 
VARIABLE TMP
CREATE ARRAYTMP 

\ Converte un indirizzo a 32 bit dal formato ARM al formato GPU.
: ARM2GPU
	TMP !
	CREATE ARRAYTMP	E51F0004 , 	\ ldr r0, [pc, #-4]		// load immediato a 32 bit memorizzato subito dopo
					TMP @ , 	\ 	// Variabile in input a 32 bit
					e59f1008 , 	\ ldr	r1, [pc, #8]
			   		e5911000 , 	\ ldr	r1, [r1]
					e1800001 , 	\ orr	r0, r0, r1
					BX_LR , 	\ bx	lr
					0000ef34 , 	\ .word	0000ef34
	DROP \ARRAYTMP JSR
;

\ Converte un indirizzo a 32 bit dal formato GPU al formato ARM.
: GPU2ARM	\ (GPUaddr -- ARMaddr)
	TMP !
	CREATE ARRAYTMP	E51F0004 , 	\ ldr r0, [pc, #-4]		// load immediato a 32 bit memorizzato subito dopo
					TMP @ , 	\ 	// Variabile in input a 32 bit
					e59f1008 , 	\ ldr	r1, [pc, #8]
					e5911000 ,  \ ldr	r1, [r1]
					e1c00001 , 	\ bic	r0, r0, r1
					BX_LR , 	\ bx	lr
					0000ef34 , 	\ .word	0000ef34
	DROP \ARRAYTMP JSR
;

\
\CREATE ARRAYTMP	E51F0004 , A6A6A6A6 , e59f1008 , e5911000 , e1800001 , e12fff1e , 0000ef34 , 
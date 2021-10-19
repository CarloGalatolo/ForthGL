\ Funzioni di conversione degli indirizzi da ARM a GPU e viceversa.

\ Importare "se-ans.f" prima.
HEX

\ e12fff1e CONSTANT BX_LR

\ Converte un indirizzo a 32 bit dal formato ARM al formato GPU.
: ARM2GPU   C0000000 OR ;    \ (ARMaddr -- GPUaddr)

\ Converte un indirizzo a 32 bit dal formato GPU al formato ARM.
: GPU2ARM   3FFFFFFF AND ;  \ (GPUaddr -- ARMaddr)

\

\Framebuffer.f get dimension of the framebuffer

60 MBMP ! 
0 MBMP 4 + ! 
GPWH MBMP 8 + ! 
8 MBMP C + ! 
10 18 STORE0
GVWH MBMP 1C + ! 
8 MBMP 20 + ! 
24 2C STORE0
GDPH MBMP 30 + ! 
4 MBMP 34 + ! 
38 3C STORE0
GPTH MBMP 40 + ! 
4 MBMP 44 + !
48 60 STORE0


MBME VMBW !
MBMP 14 + @ RWH !
MBMP 18 + @ RHT !
RHT @ 3f + 40 / BHT !
RWH @ 3f + 40 / BWH !

DROPMB

\end Framebuffer.f

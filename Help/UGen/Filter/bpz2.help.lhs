bpz2 in

Two zero fixed midpass.  This filter cuts out 0 Hz and the Nyquist
frequency.

> n <- whiteNoise AR
> audition $ bpz2 (n * 0.25)
oneZero in coef

One zero filter

> n <- whiteNoise AR
> audition $ oneZero (n * 0.5) 0.5

> n <- whiteNoise AR
> audition $ oneZero (n * 0.5) (-0.5)

> n <- whiteNoise AR
> audition $ oneZero (n * 0.5) (line KR (-0.5) 0.5 10 RemoveSynth)
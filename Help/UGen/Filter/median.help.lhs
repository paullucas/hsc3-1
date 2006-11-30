median length in

Median filter.

Signal with impulse noise.

> n <- dust2 AR 100
> audition $ median 3 (saw AR 500 * 0.1 + n * 0.9)

The median length can be increased for longer duration noise.

> n <- dust2 AR 100
> audition $ median 5 (saw AR 500 * 0.1 + lpz1 (n * 0.9))

Long Median filters begin chopping off the peaks of the waveform

> let x = sinOsc AR 1000 0 * 0.2
> audition $ MCE [x, median 31 x]

Another noise reduction application. Use Median filter for high
frequency noise.  Use LeakDC for low frequency noise.

> n <- whiteNoise AR
> audition $ leakDC (median 31 (n * 0.1 + sinOsc AR 800 0 * 0.1)) 0.9
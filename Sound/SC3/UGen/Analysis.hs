module Sound.SC3.UGen.Analysis where

import Sound.SC3.UGen.Rate (Rate(KR))
import Sound.SC3.UGen.UGen (UGen, mkOsc, mkFilter)

-- | Amplitude follower.
amplitude :: Rate -> UGen -> UGen -> UGen -> UGen
amplitude r i at rt = mkOsc r "Amplitude" [i, at, rt] 1 0

-- | Compressor, expander, limiter, gate, ducker.
compander :: UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen
compander i c t sb sa ct rt = mkFilter "Compander" [i, c, t, sb, sa, ct, rt] 1 0

-- | Autocorrelation pitch follower.
pitch :: UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen
pitch i initFreq minFreq maxFreq execFreq maxBinsPerOctave median ampThreshold peakThreshold downSample = mkOsc KR "Pitch" [i, initFreq, minFreq, maxFreq, execFreq, maxBinsPerOctave, median, ampThreshold, peakThreshold, downSample] 2 0

-- | Slope of signal.
slope :: UGen -> UGen
slope i = mkFilter "Slope" [i] 1 0

-- | Zero crossing frequency follower.
zeroCrossing :: UGen -> UGen
zeroCrossing i = mkFilter "ZeroCrossing" [i] 1 0

-- Local Variables:
-- truncate-lines:t
-- End:
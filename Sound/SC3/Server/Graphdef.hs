module Sound.SC3.Server.Graphdef (graphdef) where

import Sound.OpenSoundControl
import Sound.SC3.UGen.UGen (UGen(..))
import Sound.SC3.UGen.Rate (rateId)
import Sound.SC3.UGen.Graph

-- | Byte-encode Input value.
input_u8v :: Input -> [U8]
input_u8v (Input u p) = i16_u8v u ++ i16_u8v p

-- | Byte-encode UGen value.
ugen_u8v :: Graph -> UGen -> [U8]
ugen_u8v g c@(Control _ n _)    = str_pstr n ++ i16_u8v (controlIndex g c)
ugen_u8v g (UGen r n i o s _)   = str_pstr n ++
                                  i8_u8v (rateId r) ++
                                  i16_u8v (length i) ++
                                  i16_u8v (length o) ++
                                  i16_u8v s ++
                                  concatMap (input_u8v . makeInput g) i ++
                                  concatMap (i8_u8v . rateId) o
ugen_u8v _ _                    = error "illegal input"

-- | Value of Constant.
constantValue :: UGen -> Double
constantValue (Constant n) = n
constantValue  _           = error "constantValue: non Constant input"

-- | Default value of Control.
controlDefault :: UGen -> Double
controlDefault (Control _ _ n) = n
controlDefault  _              = error "controlDefault: non Control input"

-- | Construct instrument definition bytecode.
graphdef :: String -> Graph -> [U8]
graphdef s g@(Graph n c u) = str_u8v "SCgf" ++
                             i32_u8v 0 ++
                             i16_u8v 1 ++
                             str_pstr s ++
                             i16_u8v (length n) ++
                             concatMap (f32_u8v . f64_f32 . constantValue) n ++
                             i16_u8v (length c) ++
                             concatMap (f32_u8v . f64_f32 . controlDefault) c ++
                             i16_u8v (length c) ++
                             concatMap (ugen_u8v g) c ++
                             i16_u8v (length u) ++
                             concatMap (ugen_u8v g) u

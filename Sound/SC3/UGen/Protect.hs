-- | Functions to re-write assigned node identifiers at UGen graphs.
-- Used carefully it allows for composition of sub-graphs with psuedo-random nodes.
module Sound.SC3.UGen.Protect where

import Sound.SC3.Common.UId
import Sound.SC3.UGen.Type
import Sound.SC3.UGen.UGen

{-
-- | Collect Ids at UGen graph
ugenIds :: UGen -> [UGenId]
ugenIds =
    let f u = case u of
                Primitive_U p -> [ugenId p]
                _ -> []
    in ugenFoldr ((++) . f) []
-}

-- | Replace UId /i/ at /z/ with /(e,i)/.
edit_ugenid :: ID a => a -> UGenId -> UGenId
edit_ugenid e z =
    case z of
      NoId -> NoId
      UId i -> UId (resolveID (e,i))

-- | 'edit_ugenid' of /e/ at all 'Primitive_U' of /u/.
uprotect :: ID a => a -> UGen -> UGen
uprotect e =
    let f u = case u of
                Primitive_U p -> Primitive_U (p {ugenId = edit_ugenid e (ugenId p)})
                _ -> u
    in ugenTraverse f

-- | Variant of 'uprotect' with subsequent identifiers derived by
-- incrementing initial identifier.
uprotect_seq :: ID a => a -> [UGen] -> [UGen]
uprotect_seq e =
    let n = map (+ resolveID e) [1..]
    in zipWith uprotect n

-- | Make /n/ instances of 'UGen' with protected identifiers.
uclone_seq :: ID a => a -> Int -> UGen -> [UGen]
uclone_seq e n = uprotect_seq e . replicate n

-- | 'mce' of 'uclone_seq'.
uclone :: ID a => a -> Int -> UGen -> UGen
uclone e n = mce . uclone_seq e n

-- | Left to right UGen function composition with 'UGenId' protection.
ucompose :: ID a => a -> [UGen -> UGen] -> UGen -> UGen
ucompose e xs =
    let go [] u = u
        go ((f,k):f') u = go f' (uprotect k (f u))
    in go (zip xs [resolveID e ..])

-- | Make /n/ sequential instances of `f' with protected Ids.
useq :: ID a => a -> Int -> (UGen -> UGen) -> UGen -> UGen
useq e n f = ucompose e (replicate n f)

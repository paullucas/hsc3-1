    Sound.SC3.UGen.Help.viewSC3Help "LinCongC"
    Sound.SC3.UGen.DB.ugenSummary "LinCongC"

> import Sound.SC3 {- hsc3 -}

Default SC3 initial parameters.

> g_00 = linCongC AR 22050 1.1 0.13 1 0 * 0.2

> g_01 =
>   let x = mouseX KR 20 sampleRate Linear 0.1
>   in linCongC AR x 1.1 0.13 1 0 * 0.2

Randomly modulate parameters.

> g_02 =
>   let fr = [1,0.1,0.1,0.1]
>       [n0,n1,n2,m] = map (\(i,j) -> lfNoise2 i KR j) (zip ['α'..] fr)
>       f = n0 * 1e4 + 1e4
>       a = n1 * 0.5 + 1.4
>       c = n2 * 0.1 + 0.1
>   in linCongC AR f a c m 0 * 0.2

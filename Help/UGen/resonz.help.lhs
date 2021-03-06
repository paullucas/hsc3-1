    Sound.SC3.UGen.Help.viewSC3Help "Resonz"
    Sound.SC3.UGen.DB.ugenSummary "Resonz"

> import Sound.SC3 {- hsc3 -}

> g_01 =
>   let n = whiteNoise 'α' AR
>   in resonz (n * 0.5) 2000 0.1

Modulate frequency

> g_02 =
>   let n = whiteNoise 'α' AR
>       f = xLine KR 1000 8000 10 RemoveSynth
>   in resonz (n * 0.5) f 0.05

Modulate bandwidth

> g_03 =
>   let n = whiteNoise 'α' AR
>       bw = xLine KR 1 0.001 8 RemoveSynth
>   in resonz (n * 0.5) 2000 bw

Modulate bandwidth opposite direction

> g_04 =
>   let n = whiteNoise 'α' AR
>       bw = xLine KR 0.001 1 8 RemoveSynth
>   in resonz (n * 0.5) 2000 bw

Mouse exam (1/Q = bandwidth / center-frequency)

> g_05 =
>   let n = pinkNoise 'α' AR
>       m = mouseX KR 36 85 Linear 0.2 {- midi note -}
>       w = mouseY KR 0.1 5 Linear 0.2 {- bandwidth -}
>       f = midiCPS (floorE m) {- centre frequency -}
>       rq = w / f {- 1/Q (reciprocal of Q) -}
>   in resonz (n * 0.5) f rq

    Sound.SC3.UGen.Help.viewSC3Help "TBetaRand"
    Sound.SC3.UGen.DB.ugenSummary "TBetaRand"

> import Sound.SC3 {- hsc3 -}
> import Sound.SC3.UGen.Bindings.DB.External {- hsc3 -}

> g_01 =
>     let t = dust 'α' KR 10
>         f = tBetaRand 'β' 300 3000 0.1 0.1 t
>     in sinOsc AR f 0 * 0.1

mouse control of parameters

> g_02 =
>     let t = dust 'α' AR 10
>         p1 = mouseX KR 1 5 Linear 0.2
>         p2 = mouseY KR 1 5 Linear 0.2
>         f = tBetaRand 'β' 300 3000 p1 p2 t
>     in sinOsc AR f 0 * 0.1

...audio rate crashes server...

> g_03 =
>     let t = dust 'α' AR 100
>         p1 = mouseX KR 1 5 Linear 0.2
>         p2 = mouseY KR 1 5 Linear 0.2
>     in lag (tBetaRand 'β' (-1) 1 p1 p2 t) (10 / 48000)

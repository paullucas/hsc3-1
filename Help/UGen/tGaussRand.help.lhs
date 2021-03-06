    Sound.SC3.UGen.Help.viewSC3Help "TGaussRand"
    Sound.SC3.UGen.DB.ugenSummary "TGaussRand"

> import Sound.SC3 {- hsc3 -}
> import Sound.SC3.UGen.Bindings.DB.External {- hsc3 -}

> f_01 rand_f =
>     let t = dust 'α' KR 10
>         f = rand_f 'β' 300 3000 t
>         o = sinOsc AR f 0
>         l = rand_f 'γ' (-1) 1 t
>     in pan2 o l 0.1

> g_01 = f_01 tGaussRand

compare to tRand

> g_02 = f_01 tRand

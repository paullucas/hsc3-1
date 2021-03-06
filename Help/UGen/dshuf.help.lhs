    > Sound.SC3.UGen.Help.viewSC3Help "Dshuf"
    > Sound.SC3.UGen.DB.ugenSummary "Dshuf"

> import Sound.SC3 {- hsc3 -}
> import qualified Sound.SC3.UGen.Bindings.DB.RDU as RDU {- sc3-rdu -}

> g_01 =
>     let a = dseq 'α' dinf (dshuf 'β' 3 (mce [1,3,2,7,8.5]))
>         x = mouseX KR 1 40 Exponential 0.1
>         t = impulse KR x 0
>         f = demand t 0 a * 30 + 340
>     in sinOsc AR f 0 * 0.1

> g_02 =
>     let a = dseq 'α' dinf (dshuf 'β' 5 (RDU.randN 81 'γ' 0 10))
>         x = mouseX KR 1 10000 Exponential 0.1
>         t = impulse AR x 0
>         f = demand t 0 a * 30 + 340
>     in sinOsc AR f 0 * 0.1

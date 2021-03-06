    Sound.SC3.UGen.Help.viewSC3Help "WrapIndex"
    Sound.SC3.UGen.DB.ugenSummary "WrapIndex"

> import Sound.SC3 {- hsc3 -}

> g_01 =
>     let b = asLocalBuf 'α' [200,300,400,500,600,800]
>         x = mouseX KR 0 18 Linear 0.1
>         f = wrapIndex b x
>     in sinOsc AR f 0 * 0.1

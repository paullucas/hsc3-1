    Sound.SC3.UGen.Help.viewSC3Help "NHHall"
    Sound.SC3.UGen.DB.ugenSummary "NHHall"

> import Sound.SC3 {- hsc3 -}
> import Sound.SC3.UGen.Bindings.DB.External {- hsc3 -}

> g_01 =
>   let in1 = soundIn 0
>       in2 = soundIn 1
>       rt60 = mouseX KR 0.1 10.0 Linear 0.1
>   in nhHall in1 in2 rt60 0.5 200 0.5 4000 0.5 0.5 0.5 0.2 0.3

    Sound.SC3.UGen.Help.viewSC3Help "Operator.ring2"
    :t ring2

> import Sound.SC3 {- hsc3 -}

> o_01 = fSinOsc AR 800 0
> o_02 = fSinOsc AR (xLine KR 200 500 5 DoNothing) 0
> g_01 = ring2 o_01 o_02 * 0.125

is equivalent to:

> g_02 = ((o_01 * o_02) + o_01 + o_02) * 0.125

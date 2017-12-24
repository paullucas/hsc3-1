    Sound.SC3.UGen.Help.viewSC3Help "IIRFilter"
    Sound.SC3.UGen.DB.ugenSummary "IIRFilter"

> import Sound.SC3 {- hsc3 -}
> import Sound.SC3.UGen.Bindings.DB.External {- hsc3 -}

> g_01 =
>   let x = mouseX KR 20 12000 Exponential 0.2
>       y = mouseY KR 0.01 1 Linear 0.2
>       o = lfSaw AR (mce [x * 0.99,x * 1.01]) 0 * 0.1
>       freq = sinOsc KR (sinOsc KR 0.1 0) (1.5 * pi) * 1550 + 1800
>       s = iirFilter o freq y
>   in combN s 0.5 (mce2 0.4 0.35) 2 * 0.4 + s * 0.5


(
z = {
    var sig, freq;
    freq = MouseX.kr(20,12000,\exponential);
    sig = IIRFilter.ar(
        LFSaw.ar([freq * 0.99, freq * 1.01], 0, 0.1) ! 2,
        SinOsc.kr(SinOsc.kr(0.1),1.5pi,1550,1800),
        MouseY.kr(0.01,1,\linear));
     (CombN.ar(sig, 0.4, [0.4,0.35],2) * 0.4) + (sig * 0.5);
}.play)
z.release

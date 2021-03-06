    > Sound.SC3.UGen.Help.viewSC3Help "Dstutter"
    > Sound.SC3.UGen.DB.ugenSummary "Dstutter"

> import Sound.SC3 {- hsc3-}
>
> g_01 =
>     let inp = dseq 'α' dinf (mce [1,2,3])
>         nse = diwhite 'β' dinf 2 8
>         rep = dstutter 'γ' nse inp
>         trg = impulse KR (mouseX KR 1 40 Exponential 0.2) 0
>         frq = demand trg 0 rep * 30 + 340
>     in sinOsc AR frq 0 * 0.1

see also <https://www.listarc.bham.ac.uk/lists/sc-users/msg14775.html>

> g_02 =
>     let a z = let xr = dxrand z dinf (mce [0.1,0.2,0.3,0.4,0.5])
>                   lf = dstutter z 2 xr
>                   du = duty AR lf 0 DoNothing lf
>                   tr = abs (hpz1 du) >* 0
>                   ph = sweep tr (1/du)
>               in linExp ph 0 1 (rand z 50 100) (rand z 500 2000)
>         f = mce (map a ['a'..'h'])
>         [s0,s1] = mceChannels (splay (sinOsc AR f 0) 1 1 0 True)
>         o = limiter (rotate2 s0 s1 (lfSaw KR 0.1 0)) 1 1e-2
>     in o * 0.25



(

x = {

var lodriver, locutoffenv, hidriver, hicutoffenv, freqs, res, thwack;

locutoffenv = EnvGen.ar(Env.perc(0.01, 5)) * 20000 + 10;

lodriver = LPF.ar(WhiteNoise.ar(0.1), locutoffenv);

hicutoffenv = 10001 - (EnvGen.ar(Env.perc(1, 3)) * 10000);

hidriver = HPF.ar(WhiteNoise.ar(0.1), hicutoffenv);

hidriver = hidriver * EnvGen.ar(Env.perc(1, 2, 0.25));

thwack = EnvGen.ar(Env.perc(0.001,0.001,1));

freqs  = {exprand(300, 20000)}.dup(100);

res    = Ringz.ar(lodriver + hidriver + thwack, freqs).mean;

((res * 1) + (lodriver * 2) + thwack).dup;

}.play;

)


x.free;
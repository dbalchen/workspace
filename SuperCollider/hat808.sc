// =====================================================================
// 808 High Hat
// =====================================================================

SynthDef(\hat808, {|out=0, freq=230, hpf=6500, release=0.15, amp=1, fxb=0, fxv=0, bbcb=0, bbcv=0|
    var pulse, sig, env, freqs;
    freqs = [freq, freq * 1.4471, freq * 1.617, freq * 1.9265, freq * 2.5028, freq * 2.6637];
    pulse = Mix.new(Pulse.ar(freqs, {0.9.rand}!6, mul: 0.15));
    sig = RHPF.ar(RHPF.ar(pulse, hpf), hpf);
    env = EnvGen.kr(Env.perc(0, release), doneAction:2);
    sig = sig*env;
    Out.ar(out, Pan2.ar(sig * amp, 0));
}).store;
// =====================================================================
// All purpose Wavetable oscallator
// =====================================================================

"/home/dbalchen/workspace/SuperCollider/makeWaveTable.sc".load;


SynthDef("vosc", {
    arg ss, freq = 55, out = 0, amp = 0.5, lagt = 0, da = 2, gate = 0,windex = 1,
    attack = 0, decay = 0, sustain = 1, release = 0.5,
    fattack = 0, fdecay = 0,fsustain = 1, frelease = 0, aoc = 1, gain = 2, cutoff = 5000.00,
    spread = 1, balance = 0;

    var sig, env, fenv;

    windex = MouseX.kr(0,windex - 1);

    env = Env.adsr(attack,decay,sustain,release);
    env = EnvGen.kr(env, gate: gate, doneAction:da);

    fenv = Env.adsr(fattack,fdecay,fsustain,frelease);
    fenv = EnvGen.kr(fenv, gate,doneAction:da);
    fenv = aoc*(fenv - 1) + 1;

    freq = Lag.kr(freq,lagt);
    sig = VOsc.ar(ss + windex,freq,0,mul:env);

    sig = MoogFF.ar
    (
        sig,
        cutoff*fenv,
        gain
    );

    sig = Splay.ar(sig,spread,center:balance);
    Out.ar(out,sig * amp);

}).store;



SynthDef("voscMono", {
    arg ss, freq = 55, out = 0, amp = 0.5, lagt = 0, windex = 1,
    vcaIn = 9999, vcfIn = 9999,
    aoc = 1, gain = 2, cutoff = 5000.00,
    spread = 1, balance = 0;

    var sig, env, fenv;

    windex = MouseX.kr(0,windex - 1);

    env = In.ar(vcaIn);

    fenv = In.ar(vcfIn);
    fenv = aoc*(fenv - 1) + 1;

    freq = Lag.kr(freq,lagt);
    sig = VOsc.ar(ss + windex,freq,0,mul:env);

    sig = MoogFF.ar
    (
        sig,
        cutoff*fenv,
        gain
    );

    sig = Splay.ar(sig,spread,center:balance);
    Out.ar(out,sig * amp);

}).store;



/* Example


~wavetables.free;
~wavetables = ~fileList.value("/home/dbalchen/Desktop/TrumpetSC/");

~windex = ~wavetables.size;

~wavebuff = ~loadWaveTables.value(~wavetables);

~aa = Synth("vosc");
~aa.set(\ss,~wavebuff);
~aa.set(\windex, ~windex);
~aa.set(\freq,110);
~aa.set(\cutoff,10000);
~aa.set(\amp,1);
~aa.set(\gate,1);

*/


// =====================================================================
// Samplers
// =====================================================================

Help.gui;
Quarks.gui;

s = JStethoscope.defaultServer.boot;
JFreqScope.new( 400, 200, 0 );


 SynthDef(\Sampler, {arg out = 0, bufnum = 0, gate = 1, da = 2, rate = 1.0, amp = 1.0, attack = 0, sustain = 1, release = 0 ;
     var x,z,q;
     q = EnvGen.kr( Env.asr(attack,sustain,release),gate,doneAction:da);
     x = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate*gate,gate,0,0, doneAction:da)*amp;
     z = x * q;
     Out.ar(out,z)}).store;


 SynthDef(\LoopSampler, {arg out = 0, bufnum = 0, gate = 1, da = 2, rate = 1.0, imp = 3, amp = 0.5, attack = 0, sustain = 1, release = 0 ;
     var x,z,q;
     q = EnvGen.kr( Env.asr(attack,sustain,release),gate,doneAction:da);
	 x = amp*PlayBufCF.ar(2, bufnum, BufRateScale.kr(bufnum)*rate,Impulse.kr((1/imp)*rate),((1/rate) * 44100));
     z = x * q;
     Out.ar(out,z)}).store;






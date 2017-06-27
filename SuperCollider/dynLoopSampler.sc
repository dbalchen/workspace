~makeLoopSampler = ({arg name;
 
 SynthDef(name, {arg out = 0, bufnum = 0, gate = 1, da = 2, midi = 33, imp = 3,basef = 33,amp = 0.5, attack = 0.5, sustain = 3, release = 0 ;
     var x,z,q,i;
     i = midi.midicps/basef.midicps;
     q = Env.linen(attack,sustain - attack,release, 0.6, 'sine');
     q = EnvGen.kr(q,gate,doneAction:da);
	 x = amp*PlayBufCF.ar(2, bufnum, BufRateScale.kr(bufnum)*i,Impulse.kr((1/imp)*i),((1/i) * 44100));
     z = x * q;

	 z = Splay.ar(z);
     Out.ar(out,z)});
});


~makeLoopSamplerMidi = ({arg name;
 
 SynthDef(name, {arg out = 0, bufnum = 0, gate = 1, da = 2, midi = 33, imp = 3,basef = 33,amp = 0.25, attack = 0.5, sustain = 3, release = 0 ;
     var x,z,q,i;
     i = midi.midicps/basef.midicps;
     q = Env.asr(attack,1.5,0.50, 1);
     q = EnvGen.kr(q,gate,doneAction:da);
	 x = amp*PlayBufCF.ar(2, bufnum, BufRateScale.kr(bufnum)*i,Impulse.kr((1/imp)*i),((1/i) * 44100));
     z = x * q;
     Out.ar(out,z)});
});

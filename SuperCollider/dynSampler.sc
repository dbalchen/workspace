
~makeSampler = ({arg name;
 
 SynthDef(name, {arg out = 0, bufnum = 0, gate = 0, midi = 33, da = 2, rate = 1.0, basef = 33, amp = 0.50, attack = 0, sustain = 1, release = 0 ;
     var x,z,q,i;

     i = midi.midicps/basef.midicps;
     q = EnvGen.kr( Env.linen(attack,sustain - attack,release, 0.6, 'sine'),gate,doneAction:da);
     x = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate*gate*i,gate,0,0, doneAction:da)*amp;
     z = x * q;
     z = Splay.ar(z);
     Out.ar(out,z)});
});

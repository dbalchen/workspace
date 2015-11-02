SynthDef("Thunder",{arg out = 0,gate = 1,amp = 1;

    var sound,trig;

    trig = gate*LFNoise1.kr(3).clip(0,1);

    trig = trig*LFNoise1.kr(2).clip(0,1) ** 1.8;

    sound = PinkNoise.ar(trig);
    sound =  10 * HPF.ar(sound,20);

    sound =  LPF.ar(sound,LFNoise1.kr(1).exprange(100,2500)).tanh;

    sound =  GVerb.ar(sound, 270,30,0.7,drylevel:0.5);

    sound = sound*Line.kr(0,0.7,30);

    sound = Limiter.ar(amp*sound);

    Out.ar(out,0.5*sound.dup);
  }
  ).store;




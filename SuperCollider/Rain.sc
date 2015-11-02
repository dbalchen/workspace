// =====================================================================
// SuperCollider Workspace
// =====================================================================

SynthDef("Rain",{arg out = 0,gate = 1,amp = 1;
    var sound;

    sound =  0.5 * PinkNoise.ar(0.08+LFNoise1.kr(0.9,0.02));

    sound =  sound + LPF.ar(Dust2.ar(LFNoise1.kr(0.2).range(40,50)),7000);
    sound =  gate * HPF.ar(sound,400);

    sound =  3 * GVerb.ar(sound,250,100,0.25,drylevel:0.3);

    sound =  tanh(sound) * Line.kr(0,1,10);

    sound =  Limiter.ar(amp*0.5*sound);

    Out.ar(out,sound);
  }
  ).store;


SynthDef("Drops",{arg out = 0,gate = 1,amp = 1;

    var gaus, osc;
    gaus = {WhiteNoise.ar}.dup(12).sum;
    gaus = LPF.ar(BPF.ar(gaus, 50, 1/0.4), 500);
 
    osc = SinOsc.ar(gaus.linlin(-1, 1, 40, 80)) * gaus.squared * 10;
    osc = (osc - 0.35).max(0);
 
    2.do{
      osc = HPF.ar(osc, 500);
    };

    Out.ar(out,0.25*gate*amp*osc.dup);
  }
  ).store;

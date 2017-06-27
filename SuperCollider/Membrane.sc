SynthDef("Membrane",{arg out = 0,gate = 1,amp = 1,tension = 0.011,loss = 0.999;
   var osc,excitation;

   excitation = EnvGen.kr(Env.perc,
	gate
      //MouseButton.kr(0, 1, 0)
	,timeScale: 0.1, doneAction: 0) * PinkNoise.ar(0.4);

    //tension = MouseX.kr(0.01, 0.1);
    //loss = MouseY.kr(0.999999, 0.999, 1);
    osc = MembraneCircle.ar(excitation, tension, loss);

    osc = GVerb.ar(osc!2,1,1);
    Out.ar(out,0.10*gate*amp*osc.dup);
  }
  ).store;

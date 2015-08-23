 ~dynOsc = ({arg name, disp = 1;

     SynthDef(name, {
	 arg pan = 0, freq = 110, out = 16, oscSel = 1, amp = 0.5, lagLev = 0.0, da = 2, attack = 0.5, sustain = 3, release = 0;
	var osc, sig, oscArray, phase = 0,env;
 	 env = Env.linen(attack,sustain - attack,release, 0.6, 'sine');
         env = EnvGen.kr(q,1,doneAction:da);
	 freq = {freq * LFNoise2.kr(1,0.01,1) } ! disp;
	 oscArray = [
		     LFTri.ar(Lag.kr(freq, lagLev),phase,mul: 1),
		     LFSaw.ar(Lag.kr(freq, lagLev),phase),
		     Pulse.ar(Lag.kr(freq, lagLev),0.1,mul: 1),
		     Pulse.ar(Lag.kr(freq, lagLev),0.5,mul: 1),
		     SinOsc.ar(Lag.kr(freq, lagLev),phase,mul: 1),
		     WhiteNoise.ar(1),
		     PinkNoise.ar(1),
		     BrownNoise.ar(1),
		     GrayNoise.ar(1)
		     ];

	 sig = Select.ar(oscSel,oscArray);

	 sig = Splay.ar(sig);

	 sig = amp*Pan2.ar(sig,pan);
	 
	 Out.ar(out,env*sig);
	 
       }).send(s);
   });

// =====================================================================
// SuperCollider Workspace
// =====================================================================

~crow = Buffer.read(s, "/home/dbalchen/Music/Song#6VariationsBbMajor/samples/summerCrow.wav");
~gcrash = Buffer.read(s, "/home/dbalchen/Music/Song#6VariationsBbMajor/samples/gcrash.wav");
~crowOut = 0;
~gcrashOut = 0;

~playCrow = { arg out = 0, amp = 0.2;
 var sig;
 sig = PlayBuf.ar(1,~crow, BufRateScale.kr(~crow)*(1), loop:0);
 sig = Splay.ar(amp*sig);
 Out.ar(~crowOut,sig);
};


~playGCrash = { arg out = 0, amp = 1;
 var sig, env;

 env = Env.new([0,1], [32],8);
 env = EnvGen.kr(env, gate: 1,doneAction:2); 
 sig = PlayBuf.ar(1,~gcrash, BufRateScale.kr(~gcrash)*(1));
 sig = Splay.ar(env*amp*sig);
  Out.ar(~gcrashOut,sig);
};


//~playGCrash.play;
//~playCrow.play;

/*
SynthDef("Crow",
	 {
 arg out = 0, amp = 0.2, gate = 0, buffer = 0;
 var sig;
 sig = PlayBuf.ar(1,buffer, BufRateScale.kr(buffer)*(gate), loop:0);
 sig = Splay.ar(amp*sig);
 Out.ar(out,sig);
	 }).send(s);


SynthDef("Gcrash",
	 {
 arg out = 0, amp = 1, gate = 0, buffer = 0;
 var env,sig;

env = Env.new([0,1], [32],8);
 env = EnvGen.kr(env, gate: gate,doneAction:2); 
 sig = PlayBuf.ar(1,buffer, BufRateScale.kr(buffer)*(gate));
 sig = Splay.ar(env*amp*sig);

	 }).send(s);

~pc = Synth("Gcrash");~pc.set(\buffer,~gcrash);~pc.set(\out,0);~pc.set(\gate, 1);

*/
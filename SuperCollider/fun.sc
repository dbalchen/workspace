// =====================================================================
// SuperCollider Workspace
// =====================================================================



//redFrik - redo_minimalish sketch
(
s.waitForBoot{
	
	SynthDef(\p, {|out= 0, freq= 400, amp= 0.1, gate= 1, detune= 0|
		var env= EnvGen.ar(Env.perc(Rand(0.001, 0.01), LinRand(0.2, 0.4), amp, Rand(-9, -1)), doneAction:2);
		var snd= Mix(SinOsc.ar(freq+[0, detune*0.1], env*2pi));
		Out.ar(out, Pan2.ar(snd*env, Rand(-1, 1)));
	}).add;
	Ndef(\p, Pspawn(Pbind(\method,\par,\delta,1/8,\pattern,{Pbind(\instrument, \p, \dur,a=Pseq((1..9).sputter),\sustain,1/8/a,\degree,a,\detune,a)})));
	Ndef(\p).play(vol:0.5);
	
	Ndef(\t, {
		var mod= Saw.ar([3, 4], Saw.ar(1, 32, 128), Duty.ar(1, 0, flop(Dseq([0, 8, 1, 5])*[1, 4, 8])));
		var snd= SinOsc.ar(Saw.ar(2, 64, 99), mod)/9;
		CombN.ar(snd, 1/4, 1/4.125, SinOsc.kr(0.005, 1.5pi).range(0, 6));
	});
	Ndef(\t).play(vol:0.5);
	
	Routine.run({
		var cnt= 1;
		loop{
			var syn;
			cnt= cnt%8+1;
			syn= {
				var del= DelayN.ar(InFeedback.ar(0, 2)+(InFeedback.ar(100, 2)), 1, 1);
				SinOsc.ar(cnt*99+[0, 2], del[1..0])/4;
			}.play(outbus: 64);
			{syn.release(16)}.defer(9-cnt);
			wait(9-cnt);
		};
	});
	Ndef(\c, {InFeedback.ar(64, 2)}).play(vol:0.5);
	
	Ndef(\r, {
		var lfos= LFNoise1.ar(0.5!2);
		var snd= Crackle.ar(lfos.range(1.8, 1.98));
		Formlet.ar(snd, TExpRand.ar(200, 2000, lfos).lag(2), lfos.range(5e-4, 1e-3), 0.0012);
	});
	Ndef(\r).play(vol:0.25);
	
	Routine.run({
		loop{
			var syn= {
				var snd= Pluck.ar(Crackle.ar([1.9, 1.8]), Mix(Impulse.ar({5.linrand+1}!2, -0.125)), 0.05, 0.05.linrand);
				BPF.ar(snd, 2000.rand+100, 0.25.rrand(1.75));
			}.play(s, 62, 18);
			{syn.release(69)}.defer(18);
			wait(18);
		};
	});
	Ndef(\m, {InFeedback.ar(62, 2)*SinOsc.kr(0.006).range(0.25, 1)}).play(vol:0.5);
	
	NdefMixer(s);
	s.meter;
};
)






//////////////////////////////////
~fx=Bus.audio(s,2);

(
SynthDef(\mallet,{arg in=0,out=0,m=48,a=1,r=1,p=0;

	var sig=Array.fill(3,{|n| SinOsc.ar(m.midicps+(n*0.01),mul:a*0.3)}).sum;
        var env=EnvGen.kr(Env.perc(0.001,r),gate:1,doneAction:2);

	Out.ar(out,Pan2.ar(sig*env,pos:p));
};
).add;

SynthDef(\rev,{arg in=0,out=0;
	var sig=In.ar(in,2);
	sig=sig*0.8+CombC.ar(sig,0.5,0.3,0.5,0.2);
	Out.ar(out,sig)
	};
).add;
)

Synth(\rev,[\in:~fx]);


(
fork{
	var degrees=Prand([0,4,5,7,9,12],inf).asStream;
	var root=[36,48,60,72];
	var x;
	x=Array.new;
	a=PatternProxy(Pseq([0+root.wchoose([0.3,0.4,0.2,0.1])],inf));
	d=1/8;

	~streams=[];
	~names={|pbind| ~streams=~streams++pbind.play(quant:1)};

	~names.value(Pbind(*[\instrument:\mallet,
		               \m:a,
		               \dur:d,
		               \a:{rrand(0.4,1)*0.05},
			           \p:{rrand(-0.2,0.2)},
		               \r:{rrand(0.5,0.8)},
		               \out:~fx
	]));


    20.do({|n|
		x=x.add(degrees.next+root.wchoose([0.3,0.4,0.2,0.1]));
		x.postln;
        a.source=Pseq(x.scramble,inf);
		if ((n+1) % 6 == 0,{~names.value(Pbind(*[\instrument:\mallet,
			           \m:Pcollect({arg inval;inval-[-24,12].choose},a),
		               \dur:d,
			           \a:{rrand(0.4,1)*0.05/(n+1)},
			           \p:{rrand(-0.2,0.2)},
		               \r:{rrand(0.5,0.8)},
		               \out:~fx
		]));"new stream".postln});
			(n+1).wait});

	19.do({|n|
		x.removeAt(0);
		x.postln;
        a.source=Pseq(x.scramble,inf);
		(19-(n+1)).wait;});
4.wait;
	~streams.do{|n| n.stop;2.wait};
}
)


/* An little experiment with periodicity. 
      Maybe there can be some sync artifact...
 */

s.boot;

SynthDef(\mallet,{arg in=0,out=0,f=0,f2=0,a=0.1,r=1.8;

         var sig=Array.fill(3,{|n| SinOsc.ar(f*(n+1),mul:a/(n*n+1))}).sum;
         var env=EnvGen.kr(Env.perc(0.001,r),gate:Impulse.kr(f2),doneAction:0);

Out.ar(out,sig*env!2);
};
).add;

~root=60;
~degrees=[0,4,5,7,9,12,16,17,19,21].scramble;
~num=10;
~coeff=0.75;

Array.fill(~num,{|n| Synth.new(\mallet,[\f:(~root +~degrees[n]).midicps,\a:0.2/~num,\f2:(1+(n*~coeff))*0.1])});

s.quit;


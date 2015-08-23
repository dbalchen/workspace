// =====================================================================
// SuperCollider Workspace
// =====================================================================

Help.gui
o = Server.local.options;
o.memSize = 65536;

 
  ~xtra = {
    var trigger,trigger2, trig,out;

    trigger = TDuty.kr(Dseq([0.3,0.3,0.2,0.1,0.3,0.3,0.3,0.2,0.1,0.3,0.3,0.3,0.2,0.1,0.2,0.1,0.3,0.2,0.1,0.2,0.1,0.3], inf));
    trigger2 = Impulse;
    trigger2.postln;

    out = trigger.lag*Crackle.ar(LFSaw.kr(3).abs.lag*1.9);

	trig = trigger2.kr(1.2);
	out = out + GVerb.ar([trigger2.kr(1.2)].lag*Blip.ar(4.9,24,0.4)!2,1,1);

    out = 10*tanh(out);

    Out.ar(0,out.dup);

  };


~xtraD = {
  ~xtra.play;
	//  ~stickPat.value;
};



//~xtraD.value;


(
SynthDef( "hoover", { |freq = 220, amp = 0.1, lgu = 0.1, lgd = 1, gate = 1|
var pwm, mix, env;

freq = freq.cpsmidi.lag(lgu,lgd).midicps;
freq = SinOsc.kr( { 2.9 rrand: 3.1 }!3, {2pi.rand}!3 ).exprange( 0.995, 1.005 ) * freq;
pwm = SinOsc.kr( {2.0 rrand: 4.0}!3 ).range(0.125,0.875);

// the saw/pulses
mix = (LFSaw.ar( freq * [0.25,0.5,1], 1 ).range(0,1)
               * (1 - LFPulse.ar(freq * [0.5,1,2], 0, pwm))).sum * 0.1;

// the bass
mix = mix + LFPar.ar( freq * 0.25, 0, 0.1 );

// eq for extra sharpness
mix = BPeakEQ.ar( mix, 6000, 1, 3 );
mix = BPeakEQ.ar( mix, 3500, 1, 6 );

// kind of chorus
mix = mix + CombC.ar( mix.dup, 1/200,
                       SinOsc.kr( 3, [0.5pi, 1.5pi] ).range(1/300,1/200),
               0.0 ) * 0.5;

env = EnvGen.kr( Env.asr, gate );

Out.ar( 0, mix * env * amp );
}).store;
)

(
p = Pmono(\hoover,
               \dur, Pseq([0.25,0.5,7, 0.25]* 0.24, inf),
               \lgu, 0.15,
               \lgd, Pseq([ 0.1, 0.1, 1.5, 0.25], inf ),
               \midinote, Pseq([20, 67, 62, 20] , inf)).play;
)
p.stop;

(
p = Pmono(\hoover, \dur, 0.24,
       \lgu, 0.2,
       \lgd, Pseq([1,1,2,0.5,2,2,2,2], inf ),
        \midinote, Pseq([55, 40, 67, 55, 40, 55, 53, 52], inf)).play;
)
p.stop;




(
//Global sinusoidal envelope simulates passing of the storm
SynthDef (\global, {
	arg uitbus, duur;
	Out.kr(uitbus, EnvGen.kr(Env.sine(duur, 1), doneAction: 2))
}).send(s);
)

//Rain
// metal sound
(
SynthDef (\regen, {
	arg inbus;
	var trig;
	trig=Dust.kr(0.3*In.kr(inbus, 1)); //not to frequent, controlled by global envelope	 
Out.ar(									
	 	0, 
	 	Pan2.ar(				// in, pos, level
	 		SinOsc.ar(
	 			TRand.kr(1000, 2000, trig), //every drop has its own frequency
	 			0, 					//fase
	 			0.7 + (0.5* SinOsc.kr(	//amplitude-modulation
	 						TRand.kr(1000, 2000, trig),
	 						1.5*pi,			//fase
	 						TRand.kr(0.0, 1.0, trig)//varying modulation
	 					))						//end of modulator
	 		),								//end of SinOsc
	 			TRand.kr(-1.0, 1.0, trig),//each drop has its own position in panorama
	 			0.1								//low level, to make room for thunder
	 	)									//end of Pan2
		*EnvGen.kr(
			Env.perc(
				0.01, 						//short attack
				TRand.kr(0.1, 1.0, trig), //each drop has its own eigen decay-time
				1, 							//normal level
				-8							//good curve
			), 								//end of Env
			trig							//start raindrop
		)									//end of EnvGen
	)										//end of Out
}).send(s);
)
//Rain with white noise
(
SynthDef (\regen2, { 
	arg inbus;
	var trig;
	trig=Dust.kr(20*In.kr(inbus, 1)); //many drops, controlled by global envelope
	Out.ar(
		0, 
		Pan2.ar(
			LPF.ar(
				WhiteNoise.ar(0.1), 		//white noise with low level
				LFNoise1.kr(0.5, 200, 2000),//slightly varying sound
				1 								//normal level
			)*									//end of LPF
			EnvGen.kr(
				Env.perc(0.005, 0.005, 1, -8), //short attack and decay
				trig
			),									//end of EnvGen
			TRand.kr(-1.0, 1.0, trig),	//each drop has its own position in panorama
			1									//normal level
		) 										//end of Pan2
	);											//end of Out
}).send(s);
)
//wind
(
SynthDef(\wind, {
	arg inbus;
	var w1, w2;								//two identical functions, one left, one right
	w1=RLPF.ar(
		WhiteNoise.ar(1), 					//normal level, out level comes later
		LFNoise1.kr(0.5, 1000, 1100)*In.kr(inbus, 1) + 20,//filter controlled by global envelope. 
												//Beware of low cutoff when using RLPF 
		LFNoise1.kr(0.4, 0.45, 0.55),  // 0.55 to 1 varying reciprocal Q
		0.1*In.kr(inbus, 1)			//low level, controlled by global envelope	
	);
	w2=RLPF.ar(
		WhiteNoise.ar(1), 
		LFNoise1.kr(0.5, 1000, 1100)*In.kr(inbus, 1) + 20,
		LFNoise1.kr(0.4, 0.45, 0.55), 
		0.1*In.kr(inbus, 1)
	);
	Out.ar(0,[w1, w2] )
}).send(s);
)

//Thunder. Obviously filtered noise with two triggers: 1 for rumbling en 1 to start a thunderclap
(
SynthDef (\donder, {
	arg inbus;
	var trig1, trig2;
	trig1=Dust.kr(0.05	* In.kr(inbus, 1));//slow trigger for each thunder, controlled by global envelope	
trig2=Dust.kr(15);						//fast trigger for rumbling
	Out.ar(0,
		FreeVerb.ar( 
			Pan2.ar(
				RLPF.ar(						//filter, in, freq, rq, mul, add
					WhiteNoise.ar(1),		//white noise is the basis
					1500 *						//maximum frequency
					EnvGen.kr(				//how one thunder goes
						Env.perc(	0.05, 16, 1, -1),//attack, release, peak, curve
						trig1					//slow trigger
					)							//end of EnvGen for frequency
					* In.kr(inbus, 1) + 20,// bad things happen when frequency = 0
					0.55,						// reciprocal Q
					EnvGen.kr(				//rumbling, controls amplitude
						Env.perc(0.01, 0.5, 2, -1),
						trig2					//fast trigger
					)							// end of for amplitude
				),								//end of LPF
				LFNoise1.kr(0.1)			//freq
			),									//end of Pan2
			0.5,								//mix
			0.75,								//room
			0.5									//damp
		)										//einde FreeVerb
	)
}).send(s)
)

//Global controlbus
b=Bus.control(s, 1);
g=Synth(\global, [\uitbus, b, \duur: 300]); //300 is number of seconds. Change this if you like
//Here comes the rain
r=Synth.after(g, \regen, [\inbus, b]);
q=Synth.after(g, \regen2, [\inbus, b]);
//here comes the wind
w=Synth.after(g, \wind, [\inbus, b]);
//thunder
d=Synth.after(g, \donder, [\inbus, b]);

d.free;
r.free;
q.free;
w.free;




// sine cluster refix, kind of, a little bit, of Arvo Pärt, "Fratres"

(
{
b=fork{loop{h=[40,45,52].choose.midicps;play{Splay.ar({SinOsc.ar(exprand(h,h+(h/64)),0,0.2)}!16)*LFGauss.ar(9,1/4,0,0,2)};4.wait}};
{
5.do{[[72,69,64], [70,64,62], [67,60,70], [65,60,69], [64,60,67],[65,60,69]].do{|i| x=i.postln;10.wait;}};
10.wait;
c.stop;
4.wait;
b.stop;
}.fork;
0.1.wait;
c=fork{loop{h=x.choose.midicps;play{Splay.ar({SinOsc.ar(exprand(h-(h/128),h+(h/128)),0,0.1)}!16)*LFGauss.ar(6,1/4,0,0,2)};0.5.wait;}};
}.fork;
)


// http://twitter.com/#!/alln4tural/status/99846300173991936
// http://soundcloud.com/tengototen/esoteric-tweet


fork{loop{h=[5,7,8].choose*(2**(2..8).choose);play{Splay.ar({SinOsc.ar(exprand(h,h+(h/64)),0,0.1)}!64)*LFGauss.ar(9,1/4,0,0,2)};2.wait}};

// really i wanted to do this:
fork{loop{h=([33,38,40].choose.midicps)*(2**((0 .. 5).choose));play{Splay.ar({SinOsc.ar(exprand(h-(h/256),h+(h/256)),0,0.1)}!64)*LFGauss.ar(19,1/4,0,0,2)};4.wait}};
// or more like a constant drone:
fork{loop{h=([33,38,40].choose.midicps)*(2**((0 .. 4).choose));play{Splay.ar({SinOsc.ar(exprand(h-(h/64),h+(h/64)),0,0.1)}!8)*LFGauss.ar(19,1/4,0,0,2)};0.25.wait}};
// primes
fork{loop{h=(4 .. 100).choose.nthPrime*(2**(0..3).choose);play{Splay.ar({SinOsc.ar(exprand(h-(h/256),h+(h/256)),0,0.1)}!64)*LFGauss.ar(19,1/4,0,0,2)};2.wait}}; 
// Fibonacci
fork{loop{h=(List.fib(15).choose)*(2**(0..4).choose);play{Splay.ar({SinOsc.ar(exprand(h-(h/64),h+(h/64)),0,0.1)}!64)*LFGauss.ar(19,1/4,0,0,2)};2.wait}}; 

// but they were too long.
// __________________________
// inspired by http://sctweets.tumblr.com/post/8379573991/sinosc 
// (http://soundcloud.com/rukano)



{
var time = 8;
var freq = (40-12).midicps;
var a = VarSaw.ar(freq/2, width: XLine.ar(0.5,1,time)).range(0,XLine.ar(1,1/1000,time));
var tone = SinOsc.ar(freq).fold(-1*a,a);
Out.ar(0, tone.dup);
}.play;




(
SynthDef("pulse",{ arg freq,delayTime,amp = 1.0,attack = 0.01;
	var out,out2,env;
	env = EnvGen.kr(Env.perc(attack, 1, 5, 10),doneAction: 2);
	z = SinOsc.ar(freq,0,0.7);
	a = Pan2.ar(ToggleFF.ar(TDelay.ar(z,delayTime)) * SinOsc.ar(freq),
	         SinOsc.kr(3,0), 0.6);
	out = Pan2.ar(z, SinOsc.kr(5,1.0pi),0.7 ) + a;
	out = out * env;
	out = out.clip2(1);
		
	Out.ar(0,FreeVerb.ar(out,0.7,1.0,0.4, amp));	
}).send(s);

SynthDef("droneee", { arg freq = 440, amp = 1.0, outbus = 0, phase = 0;
	var out, env;
	env = EnvGen.kr(Env.sine(10),doneAction: 2);
	out = LFPulse.ar(freq , 0.15);
	out = RLPF.ar(out,SinOsc.kr(0.3, 0, 200, 1500), 0.1);
	out = FreeVerb.ar(out, 0.5, 0.5, 0.5) * env;
	out = Pan2.ar(out, SinOsc.kr(1/10, phase),amp);
	
    Out.ar(outbus, out);
}).send(s);


SynthDef("bass",{
	arg freq,amp,outbus=0;
	var env,out;
	out = SinOsc.ar(freq,0,amp);
	env = EnvGen.kr(Env.perc(0.5,1,1,0),doneAction: 2);	
	out = out*env;
	out = Pan2.ar(out,0);
	Out.ar(outbus,out);
		
	
}).send(s);
)


(

p = Prand( [31,40, 45,64,68,69], inf).asStream;
q = Prand( [3,0.7,1,0.5], inf ).asStream;
e = Prand([59,72,76,79,81,88,90],inf).asStream;

t = Task({
		inf.do({
		
		if( 0.1.coin, {
			Synth("pulse",
			     [\freq,e.value.midicps,
			      \amp,0.07.rand +0.2,
			      \attack,7.0.rand,
			            \delayTime, 0.02;
			            ]);
		   });


		Synth("droneee",
		       [\outBus,0,
		        \freq, p.value.midicps,
		        \amp, (0.02.rand2 + 0.05) * 0.7,
		        \phase,[0,1.5pi].wchoose([0.5,0.5]);
		        ]);
		q.value.wait;
		
		Synth("bass",[\freq,31.value.midicps,\amp,0.3]);

	            });
});

t.start;
)



(
var max_spawn = 40; // reduce if get high load
var r_prob = 0.5; // prob of field rotation
fork { loop { // original rukano tweet: http://goo.gl/ttj30
	var len = 16.rrand(3.5);
	var h = [100,800,3000].choose;
	play {
		var sig = Splay.ar({
			    SinOsc.ar(exprand(60,h),0,0.1)
		    } ! max_spawn.rrand(2), 
			1, 
			LFGauss.ar(len,1/4.rrand(2.0),0,0,2)
		);
		r_prob.coin.if({ Rotate2.ar(sig[0],sig[1],LFSaw.kr((len/8).rrand(len).reciprocal * [-1,1].choose)) },{ sig });
	};
	len.wait;
}};
fork { loop {
	var len = 16.rrand(3.5);
	var top_freq = Array.rand(10, 100, 7000).choose;
	var ugens = [LFPulse,SinOsc,LFSaw,LFNoise2];
	var kind = 0.5.coin.if({ugens},{[ugens.choose]}); // mixed or not
	play { 
		var sig = Splay.ar({ kind.choose.ar(
			0.5.coin.if({
				Line.kr(
					top_freq.linlin(100, 7000, 40, 300).perform(0.5.coin.if({ \exprand },{ \rand }), top_freq),
					top_freq.linlin(100, 7000, 40, 300).perform(0.5.coin.if({ \exprand },{ \rand }), top_freq),
					len.rrand(len/4)
				)},{
					top_freq.linlin(100, 7000, 40, 300).perform(0.5.coin.if({ \exprand },{ \rand }), top_freq)
				}
			), 
			mul: 0.5.coin.if({0.05.rrand(0.25)},{Line.kr(0.3.rrand(0), 0.3.rrand(0), (len/4).rrand(len))})
		)} ! 5.exprand(max_spawn))
		*
		LFGauss.kr(
			Line.kr(
				(1..20).choose.linexp(1, 20, 1/10, 20), 
				(1..20).choose.linexp(1, 20, 1/10, 20), 
				len.rrand(len/4)
			), 
			(3,3.2..6).choose.reciprocal, 
			loop: 0.7.coin.binaryValue
		)
		*
		EnvGen.kr(Env([0,1,0],[0.03.exprand(2), len.rrand(len/2)],[4.rrand(-4)]), doneAction: 2);
		r_prob.coin.if({ Rotate2.ar(sig[0],sig[1],LFSaw.kr((len/8).rrand(len).reciprocal * [-1,1].choose)) },{ sig });
	};
	len.postln.wait;
}};
fork { loop { 
	var len = 40.rrand(5.0);
	var ugens = [Klank, DynKlank];
	var kind = 0.5.coin.if({ugens},{[ugens.choose]}); // mixed or not
	play {
		var sig = LPF.ar(
			Splay.ar({ kind.choose.ar(
				`[
					Array.perform(0.5.coin.if({\rand},{\exprand}), 10, 60.exprand(300), 18000.rrand(4500)),
					Array.rand(10, 0.05, 0.25),
					Array.rand(10, 0, pi),
				],
				Impulse.ar(TExpRand.kr(0.1, 10, Dust.kr((2,4..16).choose/len))),
				0.5.coin.if({1},{Line.kr(1, 0.5.rrand(3), 0.5.rrand(len))})
			) } ! 1.exprand(max_spawn)),
			2000.rrand(18000),
			EnvGen.kr(
				Env(
					Array.rand(8, 0.2, 0.01).add(0).normalize * 0.1.rrand(0.33), 
					Array.rand(7, 0, 1.0).add(1).normalizeSum * len,
					Array.rand(8, -4, 4.0) 
				), 
				doneAction: 2
			)
		);
		r_prob.coin.if({ Rotate2.ar(sig[0],sig[1],LFSaw.kr((len/8).rrand(len).reciprocal * [-1,1].choose)) },{ sig });
	};
	len.postln.wait; 
}};
)


(
{ 
	Limiter.ar(
		GVerb.ar(
			(	
				BPF.ar(
					WhiteNoise.ar([0.07,0.07]) + Blip.ar([13,19], 200.rand, mul:0.5),
					SinOsc.kr(
						SinOsc.kr([1/108,1/109]).range(1/108, 1/13)
					).exprange(10, 23000),
					PMOsc.kr(1/54,1/216, 3).range(0.1, 2)
				) 
				* 
				SinOsc.ar(Array.rand(20, 1/216, 1), mul: Array.rand(20, 0.2, 1)).reshape(10,2)
			).sum,
			roomsize:10,
			damping: PMOsc.kr(1/27, 1/108, 3).range(0.5, 1), 
			drylevel: SinOsc.kr(1/9).range(0.1, 1)
		)
		+
		GVerb.ar(
			Pan2.ar(
				LPF.ar(
					DynKlank.ar(
						`[
							Array.rand(6, 600, 4000).collect({|freq|
								SinOsc.kr(1/108).range(freq/2,freq)
							}), 
							nil, 
							Array.rand(6, 1/108, 1/27).collect({|freq|
								SinOsc.kr(freq).range(1/108,1/3)
							})
						],
						Limiter.ar(
							Dust.ar( SinOsc.kr(1/256).exprange(1/27, 3), TRand.kr(0.15, 0.25, Dust.kr(1/9))) 
							+ 
							Impulse.ar( SinOsc.kr(1/108).exprange(1/54, 3), 0, TRand.kr(0.6, 0.8, Dust.kr(1/3)))
						)
					),
					1700,
					LFPar.kr(1/27).exprange(0.05, 0.2)
				),
				SinOsc.kr(1/9).range(-0.2, 0.2)
			),
			roomsize: 30,
			drylevel: 0.5
		)
	)
}.play;
)


// up
(
play{
	x = BPF.ar(
		PinkNoise.ar(0.2!2),
		100,
		0.2
	)*Line.kr(1,0,1);
	Fb({
		|fb|
		FreqShift.ar(fb+x, 5);
	})
}
)


// down
(
play{
	x = BPF.ar(
		PinkNoise.ar(0.2!2),
		8000,
		0.2
	)*Line.kr(1,0,1);
	Fb({
		|fb|
		FreqShift.ar(fb+x, -4);
	})
}
)


(
{
	Limiter.ar(HPF.ar(
		GVerb.ar(
			Pan2.ar(
				PMOsc.ar(
					Demand.kr(
						Impulse.kr(
							SinOsc.kr(SinOsc.kr(1/30).range(1/10, 1/15)).range(0, 25)
							* LFPulse.kr(0.2).range(0.5, 1)
							+ 
							LFDNoise3.kr(1/10, 10, 10)
						), 
						0, 
						Dxrand(Array.geom(100, 50, 1.06), inf) + Dgeom(1, 1.005)
					),
					[[3,5],[7,11]] + SinOsc.ar([1/60, 1/45]).range(0, 1300),
					Demand.kr(
						Impulse.kr(SinOsc.kr(0.1).range(0.1, 20)),
						0,
						Dxrand(Array.series(13, 0, 0.5), inf)
					)
				).sum,
				SinOsc.ar(1, mul:0.5),
				LFPar.ar([1/5,1/3]).range(0.3, 1)
			), 
			250, 
			0.5, 
			damping:SinOsc.kr(1/20).range(0.2,0.7), 
			drylevel: SinOsc.kr(1/15).range(0.2,0.7), 
			earlyreflevel:0.3
		) * 0.1
		+
		LFDNoise3.ar(SinOsc.kr(1/15, [0, pi/4]).range(100,350), 0.3),
		[SinOsc.ar(1/45, [0,pi/2]).range(20, 120)]
	))
}.play
)

(
{
({RHPF.ar(OnePole.ar(BrownNoise.ar, 0.99), LPF.ar(BrownNoise.ar, 14)
* 400 + 500, 0.03, 0.003)}!2)
+ ({RHPF.ar(OnePole.ar(BrownNoise.ar, 0.99), LPF.ar(BrownNoise.ar, 20)
* 800 + 1000, 0.03, 0.005)}!2)
* 4
}.play
)

play{a=Impulse;tanh(a.kr(8).lag*Crackle.ar(LFSaw.kr(3).abs.lag*1.8)+GVerb.ar([a.kr(2)+a.kr(4,0.5)].lag*Blip.ar(4.9,7,0.4)!2,1,1)*5)}

(

{
	var	sig, sig1, sig2, lpf, popHz, lagtime, noise, popHzMul,
		pan1, pan2, panmod1, panmod2;
	popHzMul = Decay.kr(Dust.kr(0.15), 3, 10, 0.8);
	popHz = 	LFNoise1.kr(20).exprange(0.1,10) * popHzMul;
	sig = Dust2.ar(popHz);
	lpf = LFNoise1.kr(10).exprange(1000,20000);
	lagtime = LFNoise1.kr(20).range(0.008,0.0001);
	sig = LPF.ar(sig, lpf);
	sig = Lag.ar(sig, lagtime);
	sig = sig + FreeVerb.ar(sig, 0.8, 1, mul:0.11);
	panmod1 = LFNoise1.kr(5).range(0.2,0.7);
	panmod2 = LFNoise1.kr(5).range(0.2,0.7);
	pan1 = SinOsc.kr(panmod1).range(-0.2,0.2);
	pan2 = SinOsc.kr(panmod2).range(-0.2,0.2);
	sig1 = Pan2.ar(sig, pan1, 0.5);
	sig2 = Pan2.ar(sig, pan2, 0.5);
	sig = sig1 + sig2;
	sig = sig + BPF.ar(BrownNoise.ar([0.0025,0.0025]), 7200, 0.4);
	sig = sig + HPF.ar(Crackle.ar([1.999,1.999], 0.0025),2000);
	Out.ar(0, sig*6);
}.play
)



(
play {
    Limiter.ar(
        tanh(
            3 * GVerb.ar(
                HPF.ar(
                    PinkNoise.ar(0.08+LFNoise1.kr(0.3,0.02))+LPF.ar(Dust2.ar(LFNoise1.kr(0.2).range(40,50)),7000),
                    400
                ),
                250,100,0.25,drylevel:0.3
            ) * Line.kr(0,1,10)
        ) + (
            GVerb.ar(
                LPF.ar(
                    10 * HPF.ar(PinkNoise.ar(LFNoise1.kr(3).clip(0,1)*LFNoise1.kr(2).clip(0,1) ** 1.8), 20)
                    ,LFNoise1.kr(1).exprange(100,2500)
                ).tanh,
               270,30,0.7,drylevel:0.5
            ) * Line.kr(0,0.7,30)
        )
    )
};
)


//additive synthesis bell
//port of the pure-data example: D07.additive.pd
(
s.waitForBoot{
	SynthDef(\risset, {|out= 0, pan= 0, freq= 400, amp= 0.1, sustain = 2, t_trig= 1|
		var amps= #[1, 0.67, 1, 1.8, 2.67, 1.67, 1.46, 1.33, 1.33, 1, 1.33];
		var durs= #[1, 0.9, 0.65, 0.55, 0.325, 0.35, 0.25, 0.2, 0.15, 0.1, 0.075];
		var frqs= #[0.56, 0.56, 0.92, 0.92, 1.19, 1.7, 2, 2.74, 3, 3.76, 4.07];
		var dets= #[0, 1, 0, 1.7, 0, 0, 0, 0, 0, 0, 0];
		var src= Mix.fill(11, {|i|
			var env= EnvGen.ar(Env.perc(0.005, sustain*durs[i], amps[i], -4.5), t_trig);
			SinOsc.ar(freq*frqs[i]+dets[i], 0, amp*env);
		});
		Out.ar(out, Pan2.ar(src, pan));
	}).add;
};
)

a= Synth(\risset, [\freq, 72.midicps, \sustain, 4])
a.set(\t_trig, 1)
a.set(\freq, 100.midicps, \sustain, 3, \t_trig, 1)
a.set(\freq, 60.midicps, \sustain, 1, \t_trig, 1)
a.set(\freq, 90.midicps, \sustain, 0.5, \t_trig, 1)
a.free

(
Routine({
	var a= Synth(\risset);
	20.do{
		var dur= 0.2.exprand(3.0);
		var fre= 60.0.exprand(5000.0);
		("dur:"+dur+"fre:"+fre).postln;
		a.set(\t_trig, 1, \freq, fre, \sustain, dur);
		dur.wait;
	};
	a.free;
	"done".postln;
}).play;
)

(
var base = 2.6; // or TempoClock.tempo; // set tempo
thisThread.randSeed = 1000000.rand.postln; // to recall interesting variants
f = { |out = 0|
	var sig = Pan2.ar(
		Klank.ar(
			`[ Array.rand(30, 50, 10000), Array.rand(30, 0, 1.0), Array.rand(30, 0, 1.0) ],
			[
				LFBrownNoise2.ar( LFDNoise3.kr(base / 4).range(20, 10000), 0.005),
				GbmanL.ar( MouseX.kr(0, Array.geom(5,2,2).choose), 3.0.rand2, 3.0.rand2 ) / 3,
				Impulse.ar( A2K.kr(GbmanL.ar(MouseY.kr(0, Array.geom(5,2,2).choose), 3.0.rand2, 3.0.rand2)) * base / 4 ) / 4,
				Dust.ar( Array.geom(4,base/2,2).choose ) / 4,
				Impulse.ar( Array.geom(4,base/2,2).choose ) / 4,
				LFPulse.ar( LFDNoise3.kr(base).range(62.rrand(100), 110.rrand(350)), mul: 0.003 )
			].choose
		)
		* 
		SinOsc.kr(
			Demand.kr(Impulse.kr(base / 16), 0, Dxrand(Array.geom(5, base / 4, 2), 8)),
			mul:0.1 * A2K.kr(GbmanL.ar(Array.geom(5,1/8,2).choose, 3.0.rand2, 3.0.rand2)), add:0.1
		),
		LFTri.kr(base / (4,6..24).choose, mul: 0.7.rrand(0.2), add: 0.3.rand)
	);
	Out.ar(out, sig );
};
{ ReplaceOut.ar(0, Limiter.ar(FreeVerb.ar(In.ar(0,2), 1.0.rrand(0.33)))) }.play( addAction:\addToTail );
{ f.play(args:[out:0]) } ! 4.rrand(8);
)
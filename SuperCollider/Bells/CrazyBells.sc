// =====================================================================
// SuperCollider Workspace
// =====================================================================


~crazyPipe = { 
	Limiter.ar(
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
};


~crazyBells = {
var max_spawn = 40; // reduce if get high load
var r_prob = 0.5; // prob of field rotation

fork { 
loop { 
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
};


~crazyBells.value;

~crazyPipe.value;



(
~lbells = {
	var max_spawn = 40; //40; // reduce if get high load
var r_prob = 5; // prob of field rotation

fork { 
loop { 
	var len = 60;//40.rrand(5.0);
    var pars = 4;
    var qq = Array.new(pars);
	var ugens = [Klank, DynKlank];
	var kind = [Klank];//ugens;//0.5.coin.if({ugens},{[ugens.choose]}); // mixed or not
    var pickone = [106.midicps,108.midicps,111.midicps,113.midicps];
    var thechoice = pickone.choose;
	//qq.add(thechoice);
    qq = [ pickone.choose, 7152.1823395654, 7476.6751834468 ];
	//   for(1,qq.size - 1,

	//    { arg i; 
	//	  	    qq.add(thechoice.rrand(18000.rrand(4500)));
	//    }
	//   );

    //qq.postln;
	play {
		var sig = LPF.ar(
			Splay.ar({ kind.choose.ar(
				`[
					//Array.perform(\rand, 4, thechoice, 18000.rrand(4500)),
					//Array.rand(10, 1300, 18000),
					//qq,
                    [ pickone.choose, 7152.1823395654, 7476.6751834468 ],
					Array.rand(pars, 0.05, 0.25),
					Array.rand(pars, pi/3, pi),
				],
				//Impulse.ar(TExpRand.kr(0.1, 10, Dust.kr((2,4..16).choose/len)))
				//Dust.ar((2,4..16).choose/len)
                Dust.ar(0.33);
				//				,
				//			0.5.coin.if({1},{Line.kr(1, 0.5.rrand(3), 0.5.rrand(len))})
			) } ! 10), //1.exprand(max_spawn)),
			//		2000.rrand(18000),
            14000,
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
        Out.ar(0,10*sig);
	};
	len.postln.wait; 
}};
};
)
~lbells.value;


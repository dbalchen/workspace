{{GVerb.ar(
RLPF.ar(
in:WhiteNoise.ar(mul:1.0),
freq:windspd * 500 + 350,
rq:LFNoise1.kr(1, 0.3, 0.5),
mul:windspd * 0.3 + 0.05
 ),
 200, 3, 0.5, 0.2, 15, 1, 0.2, 0.2, 201)
 }}.play;
 )


( // Wind Chimes
 {var windspd, partials = 15, pars;
 windspd = LFDNoise3.kr(LFNoise1.kr(1, 0.5, 0.5), 0.5, 0.5);
 {Mix.ar({
 var trigger, key;
 trigger = Dust.kr(windspd);
 key = 660 * [1/1, 3/2, 4/3, 6/5, 16/9];
 pars = [];
 1.forBy(partials.floor, 2, {arg thisPar; pars = pars.add(thisPar)});
 DelayN.ar(HPF.ar(Pan2.ar(
 Mix.ar(
 pars.collect(
 { arg counter;
 var harmonic = counter + 1;
 DelayN.ar(
 SinOsc.ar({key.choose * harmonic + 8.4.sum3rand}) *
 EnvGen.kr(
 Env.perc(0, //attack
 windspd * 15 * (1/harmonic) + TRand.kr(-0.2, 0.2, trigger), //release
 windspd * (20/harmonic), //peak level
 (-2 - harmonic)), //curve
 trigger, //gate
 (windspd * TRand.kr(0.9, 1.0, trigger)) / harmonic //levelScale
 ), 0.01, [Rand.new(0.0, 0.01), Rand.new(0.0, 0.01)])}))/partials,
 0.5.sum3rand
 ), 500), 0.5, Rand.new(0.4, 0.5))
 }.dup(6) ) * 0.2
 } +

 {
 var windspd = LFDNoise3.ar(LFNoise1.ar(1, 0.5, 0.5), 0.5, 0.5);
	 //GVerb.ar(
 MoogFF.ar(
 in:WhiteNoise.ar(mul:1.0),
 freq:windspd * 500 + 350,
 gain:LFNoise1.kr(1, 0.3, 0.5),
 mul:windspd * 0.3 + 0.05
 )//,
	 //200, 3, 0.5, 0.2, 15, 1, 0.2, 0.2, 201)
 }.play;
 )


{LFDNoise3.kr(LFNoise1.kr(1, 0.5, 0.5), 0.5, 0.5)}.plot;



// =====================================================================
// SuperCollider Workspace
// =====================================================================

//Sound recipes from:
//Mitchell Sigman (2011) Steal this Sound. Milwaukee, WI: Hal Leonard Books
//adapted for SuperCollider and elaborated by Nick Collins (http://www.sussex.ac.uk/Users/nc81/index.html)
//under GNU GPL 3 as per SuperCollider license

//if you see strange multipliers, like *0.3, these are compensation factors for mixing together many oscillators, or loss of amplitude from filters so the patches work out to roughly equal output



//start here
(
//make sure server is booted if you want to hear any sound!
s.boot;

//bpm 120 assumed in the following, impacting on some delay recipes.
TempoClock.default.tempo = 2;
)




//pp.2-3

(
SynthDef(\prophet5pwmstrings,{|out= 0 freq = 440 amp = 1.0 gate=1 lforate = 10 lfowidth= 0.5 cutoff= 12000 rq=0.5 pan = 0.0|

        var lfo, pulse, filter, env;

        lfo = LFTri.kr(lforate*[1,1.01],Rand(0,2.0)!2);

        pulse = Pulse.ar(freq*[1,1.01],lfo*lfowidth+0.5);

        filter = RLPF.ar(pulse,cutoff,rq);

        env = EnvGen.ar(Env.adsr(0.01,0.0,1.0,0.5),gate,doneAction:2);

        Out.ar(out,Pan2.ar(Mix(filter)*env*amp*0.5,pan));

}).add
)


(
Pbind(
        \instrument,\prophet5pwmstrings,
        \midinote,Pseq([0,3,8,7,5,8,7,3]+48,inf),
        \dur,Pseq((0.5!8) ++ (0.25!8) ++ (2.0!8),inf),
        \lfowidth,Pn(Pseries(0.0,0.025,7),inf),
        \lforate,Pn(Pseries(2,1,11),inf),
        \rq,Pn(Pseries(0.9,-0.1,5),inf)
).play
)



//pp. 8-9


//vibrato on oscillator
(
SynthDef(\singleoscillatorwobble,{|out= 0 freq = 440 amp = 1.0 gate=1 lforate = 10 lfowidth= 0.5 cutoff= 12000 rq=0.5 pan=0.0|

        var lfo, pulse, filter, env;

        lfo = LFTri.kr(lforate,Rand(0,2.0)!2);

        pulse = Pulse.ar(freq*(1.0+(lfowidth*lfo)),0.5);

        filter = RLPF.ar(pulse,cutoff,rq);

        env = EnvGen.ar(Env.adsr(0.01,0.0,1.0,0.5),gate,doneAction:2);

        Out.ar(out,Pan2.ar(filter*env*amp*0.5,pan));

}).add;


SynthDef(\choruseffect, {|out =0 gate= 1|
        var source = In.ar(out,2);
        var chorus;
        var env = Linen.kr(gate, 0.1, 1, 0.1, 2);

        chorus= Mix.fill(7, {

                var maxdelaytime= rrand(0.005,0.02);

                DelayC.ar(source, maxdelaytime,LFNoise1.kr(Rand(4.5,10.5),0.25*maxdelaytime,0.75*maxdelaytime) )

        });

        XOut.ar(out,env, chorus);

}).add;

)



(
Pmono(
        \singleoscillatorwobble,
        \midinote,Pseq([0,3,8,7,5,8,7,3]+48,inf),
        \dur,Pseq((0.5!8) ++ (1.0!8) ++ (2.0!8),inf),
        \lfowidth,Pn(Pseries(0.0,0.01,7),inf),
        \lforate,Pn(Pseries(2,1,11),inf),
        \rq,Pn(Pseries(0.9,-0.1,5),inf)
).play
)


(
var p =
Pbind(
        \instrument, \singleoscillatorwobble,
        \tempo,2,
        \midinote,Pseq([0,3,8,7,5,8,7,3]+36,24),
        \dur,Pseq((0.5!8) ++ (1.0!8) ++ (2.0!8),1),
        \lfowidth,Pn(Pseries(0.0,0.01,7),4),
        \lforate,Pn(Pseries(2,1,11),3),
        \rq,Pn(Pseries(0.9,-0.1,5),6)
);


Pseq([p,Pfx(p,\choruseffect)],inf).play
)



//trying it on its own
a = Synth(\singleoscillatorwobble);
a.release






//pp. 10-11

(
SynthDef(\trianglewavebells,{|out= 0 freq = 440 amp = 0.1 gate=1 lforate = 10 lfowidth= 0.0 cutoff= 100 rq=0.5 pan=0.0|

        var osc1, osc2, vibrato, filter, env;

        vibrato = SinOsc.ar(lforate,Rand(0,2.0));

        osc1 = Saw.ar(freq*(1.0+(lfowidth*vibrato)),0.75);

        //Saw a bit rough, possibly slighter smoother:
        //osc1 = DPW4Saw.ar(freq*(1.0+(lfowidth*vibrato)),0.5);

        osc2 = Mix(LFTri.ar((freq.cpsmidi+[11.9,12.1]).midicps));

        //filter = (osc1+(osc2*0.5))*0.5; //no filter version
        filter = RHPF.ar((osc1+(osc2*0.5))*0.5,cutoff,rq);

        env = EnvGen.ar(Env.adsr(0.01,0.1,1.0,0.5),gate,doneAction:2);

        Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;
)



(
Pbind(
        \instrument, \trianglewavebells,
        \sustain,0.6,
        \amp, 0.2,
        \midinote,Pseq([0,7,3,0, 8,7,8,5, 7,12,5,3, 12,7,15,-5]+60,inf),
        \dur,Pn(Pshuf([0.5,1.0,0.5,2.0,0.5,1.0,0.5,1.5],1),inf),
        \lfowidth,Pn(Pseries(0.0,0.005,16),inf),
        \lforate,Pn(Pseries(1,0.5,16),inf),
        \rq,Pn(Pseries(0.9,-0.1,8),inf),
        \cutoff,Pn(Pseries(60,10,9),inf)
).play
)






//pp.12-3

//essentially, Pulse waveforms in multiple octaves; I've refined the patch to add freq*[1,2,3] which gives octave and octave + fifth over fundamental
(
SynthDef(\organdonor,{|out= 0 freq = 440 amp = 0.1 gate=1 lforate = 10 lfowidth= 0.0 cutoff= 100 rq=0.5 pan=0.0|

        var vibrato, pulse, filter, env;

        vibrato = SinOsc.ar(lforate,Rand(0,2.0));

        //up octave, detune by 4 cents
        //11.96.midiratio = 1.9953843530485
        //up octave and a half, detune up by 10 cents
        //19.10.midiratio = 3.0139733629359

        //Pulse version
        //pulse = Mix(Pulse.ar(([1,1.9953843530485,3.0139733629359]*freq)*(1.0+(lfowidth*vibrato)),Rand(0.4,0.6)!3,[1.0,0.7,0.3]))*0.5;

        //better alternative
        pulse = Mix(VarSaw.ar(([1,1.9953843530485,3.0139733629359]*freq)*(1.0+(lfowidth*vibrato)),Rand(0.0,1.0)!3,Rand(0.3,0.5)!3,[1.0,0.7,0.3]))*0.5;

        filter = RLPF.ar(pulse,cutoff,rq);

        env = EnvGen.ar(Env.adsr(0.01,0.5,1.0,0.5),gate,doneAction:2);

        Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;
)





(
Pbind(
        \instrument, \organdonor,
        \sustain,0.9,
        \amp, 0.2,
        \midinote,Pn(Pshuf([[0,4,7],[-1,2,7],[-3,0,5],[-1,2,7],[2,5,9],[-5,-1,4]]+60),inf),
        \dur,Pn(Pshuf([2.0,2.0,4.0,2.0],1),inf),
        \lfowidth,Pn(Pseries(0.0,0.001,16),inf),
        \lforate,Pn(Pseries(1,0.25,16),inf),
        \rq,Pn(Pseries(0.3,-0.01,8),inf),
        \cutoff,Pn(Pseries(6000,200,9),inf)
).play
)






//pp. 14-5

(
SynthDef(\werkit,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff= 100 rq=0.1 pan=0.0|

        var source, filter, env;

        source = WhiteNoise.ar;

        filter = BLowPass4.ar(source,freq,rq)*0.3;

        //env = EnvGen.ar(Env.adsr(0.01,0.0,1.0,0.1),gate,doneAction:2);
        //no gate, fixed envelope size
        env = EnvGen.ar(Env([0,1,0.5,0.0],[0.02,0.1,0.1]),doneAction:2);

        Out.ar(out,Pan2.ar((0.7*filter+(0.3*filter.distort))*env*amp,pan));

}).add;



//via Comb filter for feedback
SynthDef(\delayeffect, {|out =0 gate= 1|
        var source = In.ar(out,2);
        var delay;
        var env = Linen.kr(gate, 0.1, 1, 0.1, 2);

        delay= CombC.ar(source,0.25,0.25,2.0);

        XOut.ar(out,env, delay);

}).add;

)




//p15 book claims 'musically correct' half steps; total nonsense. I've used their suggested steps here, but the original non-pitch quantised version could be explored.
(
Pfx(
        Pbind(
                \instrument, \werkit,
                \amp, 0.2,
                \midinote,Pseq(([-1,1,-1,1,3,6,9,11]+60)++([0,3,5,6,7,8,11,14]+72),inf),
                \dur,0.25,
                \rq,0.01
        ),
        \delayeffect
).play
)







//their lasers on pp 16-17 seem just to be fast sweeps of frequency of one oscillator by a modulator oscillator, or an envelope.
(

//no use of gate, fixed length
SynthDef(\laserbeam,{|out= 0 freq = 440 amp = 0.1 attackTime= 0.04 gate=1 pan=0.0|

        var osc1, freqenv, ampenv;

        freqenv = EnvGen.ar(Env([4,0.5,1,1],[attackTime,0.01,1.0]));

        osc1 = LFTri.ar(freq*freqenv);

        //env = EnvGen.ar(Env.adsr(0.01,0.0,1.0,0.1),gate,doneAction:2);
        //no gate, fixed envelope size
        ampenv = EnvGen.ar(Env([0,1,0.5,0.0],[0.02,0.2,0.1]),doneAction:2);

        Out.ar(out,Pan2.ar(osc1*ampenv*amp,pan));

}).add;

)



(
Pfx(
        Pfx(
                Pbind(
                        \instrument, \laserbeam,
                        \amp, 0.2,
                        \midinote,Pseq([36,48,60,72,84],inf),
                        \dur,0.5,
                        \attackTime,Pstutter(8,Pseq([Pshuf((0.01,0.02..0.1),1)],inf))
                ),
                \delayeffect
        ),
        \choruseffect
).play

)





//pp. 18-19

(

//no use of gate, fixed length
SynthDef(\moogbasstone,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff= 1000 gain=2.0 lagamount = 0.01 pan=0.0|

        var osc, filter, env, filterenv;

        osc = Mix(VarSaw.ar(freq.lag(lagamount)*[1.0,1.001,2.0],Rand(0.0,1.0)!3,Rand(0.5,0.75)!3,0.33));

        //alternative: richer source: see moogbasstone2 below
        //osc = Mix(Pulse.ar(freq.lag(lagamount)*[1.0,1.001,2.0],Rand(0.45,0.5)!3,0.33));

        filterenv = EnvGen.ar(Env.adsr(0.2,0.0,1.0,0.2),gate,doneAction:2);
        filter =  MoogFF.ar(osc,cutoff*(1.0+(0.5*filterenv)),gain);

        env = EnvGen.ar(Env.adsr(0.001,0.3,0.9,0.2),gate,doneAction:2);

        Out.ar(out,Pan2.ar((0.7*filter+(0.3*filter.distort))*env*amp*1.5,pan));

}).add;

)


(
Pfx(
        Pfx(
                Pmono(
                        \moogbasstone,
                        \amp, 0.5,
                        \midinote,Pseq([24,36,48,36,35,36,43,48],inf),
                        \dur,Pstutter(8,Pseq([0.5,0.25],inf)),
                        \gain,Pn(Pseries(2,0.1,19),inf),
                        \cutoff,Pn(Pseries(4000,400,18),inf)
                ),
                \delayeffect
        ),
        \choruseffect
).play

)





(

//no use of gate, fixed length
SynthDef(\moogbasstone2,{|out= 0 freq = 440 amp = 0.1 gate=1 attackTime= 0.2 fenvamount=0.5 cutoff= 1000 gain=2.0 pan=0.0|

        var osc, filter, env, filterenv;

        //alternative: richer source
        osc = Mix(Pulse.ar(freq.lag(0.05)*[1.0,1.001,2.0],Rand(0.45,0.5)!3,0.33));

        filterenv = EnvGen.ar(Env.adsr(attackTime,0.0,1.0,0.2),gate,doneAction:2);
        filter =  MoogFF.ar(osc,cutoff*(1.0+(fenvamount*filterenv)),gain);

        env = EnvGen.ar(Env.adsr(0.001,0.3,0.9,0.2),gate,doneAction:2);

        Out.ar(out,Pan2.ar((0.7*filter+(0.3*filter.distort))*env*amp,pan));

}).add;

)


(
Pfx(
        Pfx(
                Pmono(
                        \moogbasstone2,
                        \amp, 0.8,
                        \midinote,Pseq([24,36,43,48, 43,48,36,36, 36,36,39,36, 31,31,31,31, 31,34,31,34],inf),
                        \dur,0.25,
                        \gain,Pn(Pseries(2,0.1,19),inf),
                        \cutoff,Pstutter(3,Pn(Pseries(50,250,40),inf)),
                        \attackTime,Pn(Pseries(0.0,0.01,30),inf),
                        \fenvamount,Pstutter(4,Pn(Pseries(0.0,0.05,20),inf))
                ),
                \delayeffect
        ),
        \choruseffect
).play

)







//pp. 20-21  mr ostinato


(
SynthDef(\mrostinato,{|out= 0 freq = 440 amp = 0.1 gate=1 lforate = 10 lfowidth= 0.5 pan = 0.0|

        var lfo, pulse, filter, env;

        lfo = LFTri.kr(lforate,Rand(0,2.0)!3);

        pulse = Pulse.ar(freq*[1,1.01,0.5],lfo*lfowidth+0.5);

        env = EnvGen.ar(Env.adsr(0.01,0.05,0.5,0.1),gate,doneAction:2);

        Out.ar(out,Pan2.ar(Mix(pulse)*env*amp,pan));

}).add
)


(
PmonoArtic(
        \mrostinato,
        \octave,Pseq([3,3,4,4],inf),
        \scale,[0,2,3,5,7,8,10],
        \degree,Pstutter(16,Pseq([0,2,5,3],inf)),
        \dur,0.25,
        \lfowidth,Pstutter(8,Pn(Pseries(0.0,0.05,7),inf)),
        \lforate,Pstutter(5,Pn(Pseries(0.5,0.2,11),inf)),
        \pan,Pstutter(2,Prand([-0.5,-0.3,0.3,0.5],inf))
).play
)


 //richer sequence with some heavier moments
(
Pbind(
        \instrument,\mrostinato,
        \sustain,Pstutter(64,Prand([0.1,0.5,0.7],inf)),
        \octave,Pseq([3,3,4,4,3,3,5,2],inf),
        \scale,[0,2,3,5,7,8,10],
        \degree,Pstutter(16,Prand([0,-1,1,2,-3,5,6,3,4,2],inf)),
        \dur,0.25,
        \lfowidth,Pstutter(8,Pn(Pseries(0.0,0.05,7),inf)),
        \lforate,Pstutter(5,Pn(Pseries(0.5,0.2,11),inf)),
        \pan,Pstutter(2,Prand([-0.5,-0.3,0.3,0.5],inf))
).play
)









//pp. 30-31 Synth bass layers

(
SynthDef(\bassfoundation,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff= 1000 rq=0.5 pan=0.0|

        var osc, filter, env, filterenv;

        osc = Saw.ar(freq);

        filterenv = EnvGen.ar(Env.adsr(0.0,0.5,0.2,0.2),gate,doneAction:2);
        filter =  RLPF.ar(osc,cutoff*filterenv+100,rq);

        env = EnvGen.ar(Env.adsr(0.01,0.0,0.9,0.05),gate,doneAction:2);

        Out.ar(out,Pan2.ar(filter*env*amp*2,pan));

}).add;


SynthDef(\basshighend,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff= 3000 rq=0.1 drive = 2.0 pan=0.0|

        var osc, filter, env, filterenv;
        var ab;

        //osc = Mix(VarSaw.ar(freq*[0.25,1,1.5],Rand(0.0,1.0)!3,0.9,[0.5,0.4,0.1]));
        osc = Mix(Saw.ar(freq*[0.25,1,1.5],[0.5,0.4,0.1]));
        //osc = Mix(DPW4Saw.ar(freq*[0.25,1,1.5],[0.5,0.4,0.1]));
        filterenv = EnvGen.ar(Env.adsr(0.0,0.5,0.2,0.2),gate,doneAction:2);
        filter =  RLPF.ar(osc,cutoff*filterenv+100,rq);

         //distortion
         //filter = filter.distort.softclip;

        ab = abs(filter);
         filter = (filter*(ab + drive)/(filter ** 2 + (drive - 1) * ab + 1));

        //remove low end
        filter = BLowShelf.ar(filter,300,1.0,-12);
        //dip at 1600Hz
        filter = BPeakEQ.ar(filter,1600,1.0,-6);

        env = EnvGen.ar(Env.adsr(0.01,0.0,0.9,0.05),gate,doneAction:2);

        Out.ar(out,Pan2.ar(filter*env*amp*2,pan));

}).add;

)




(
Pbind(
        \instrument,\bassfoundation,
        \midinote,36,
        \dur,0.5,
        \rq,1.0
).play
)


(
Pbind(
        \instrument,\basshighend,
        \midinote,36,
        \dur,0.5,
        \rq,1.0
).play
)


//combination
(
p = Pbind(
        \midinote,Pstutter(4,Pseq([36,43,39,31],inf)),
        \dur,0.5,
        \rq,Pstutter(4,Pn(Pseries(1.0,-0.1,8),inf)),
        \cutoff,Pstutter(4,Pn(Pseries(8000,-1000,7),inf))
);

Ppar([
        Pset(\instrument,Pseq([\bassfoundation],inf),p),
        Padd(\instrument,\basshighend,p)
]).play;
)









//pp. 32-33

(

SynthDef(\winwoodlead,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff=8000 rq=0.8 lfowidth=0.01 lforate= 8 lagamount=0.01 pan=0.0|

        var pulse, filter, env, lfo;

        lfo = LFTri.kr(lforate,Rand(0,2.0)!2);

        pulse = Mix(Pulse.ar((freq.lag(lagamount))*[1,1.001]*(1.0+(lfowidth*lfo)),[0.2,0.19]))*0.5;

        filter =  RLPF.ar(pulse,cutoff,rq);

        //remove low end
        filter = BLowShelf.ar(filter,351,1.0,-9);

        env = EnvGen.ar(Env.adsr(0.01,0.0,0.9,0.05),gate,doneAction:2);

        Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;

)



//Pmono allows use of the lag between setting frequency values
(
Pmono(
        \winwoodlead,
        \midinote,Pseq([Pshuf([60,76,77,76,74,72],2)],inf),
        \dur,Pseq([0.5,1.0,0.5,0.5,0.5,1.0],inf),
        \amp,Pseq([0,1,1,1,1,1],inf),
        \lagamount,0.1,
        \lfowidth,Pstutter(6,Pseq([0.0,0.01,0.02,0.03,0.05,0.1],inf)),
        \cutoff,Pstutter(6,Pn(Pgeom(2000,1.5,5),inf))
).play
)






//pp. 40-41

(

SynthDef(\situationsynth,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff=8000 rq=0.8 lfowidth=0.001 lforate= 3.3 pan=(-0.1)|

        var pulse, filter, env, filterenv, lfo;

        lfo = LFTri.kr(lforate,Rand(0,2.0)!2);

        pulse = Mix(Pulse.ar((((freq.cpsmidi)+[0,0.14])+(lfo*lfowidth)).midicps,[0.5,0.51]+(lfowidth*lfo)))*0.5;

        filterenv = EnvGen.ar(Env([0.0,1.0,0.3,0.0],[0.005,0.57,0.1],-3));

        filter =  RLPF.ar(pulse,100+(filterenv*cutoff),rq);

        env = EnvGen.ar(Env.adsr(0.002,0.57,1.0,0.3),gate,doneAction:2);

        Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;


SynthDef(\yazoodelayeffect, {|out =0 gate= 1 pan= 0.1|
        var source = In.ar(out,2);
        var delay;
        var env = Linen.kr(gate, 0.0, 1, 0.1, 2);

        delay= DelayC.ar(source[0].distort,0.25,0.25);

        Out.ar(out,Pan2.ar(delay*env,pan));

}).add;

)


//says original tempo 118, we'll keep 120 for note as it's so close.

//Pmono allows use of the lag between setting frequency values
(
Pfx(
        Pbind(
                \instrument,\situationsynth,
                \midinote,Pseq([1,1,13,1,-1,-1,-1,11,8,11,13,1,1,13,1,-1,-1,11,16,15,11,13]+60,inf),        \dur,Pseq([0.5,0.5,0.5,0.25,0.5,0.5,0.25,0.25,0.25,0.25,0.25,0.5,0.5,0.5,0.25,0.5,0.5,0.25,0.25,0.25,0.25,0.25],inf),
                \lfowidth,0.2,
                \cutoff,6000,
                \rq,0.6,
                \pan,-0.1,
                \amp,0.3
        ),
        \yazoodelayeffect
).play
)









//pp. 42-3 not an exact attempt, but some resonance and distortion fun

(

SynthDef(\ressquares,{|out= 0 freq = 440 amp = 0.1 gate=1 cutoff=8000 rq=0.8 pan=(-0.1)|

        var pulse, filter, env;

        //2 cents detune for second oscillator
        pulse = Mix(Pulse.ar( ((freq.cpsmidi)+[0,0.02]).midicps, 0.5))*0.5;

        filter =  BLowPass.ar(pulse,100+cutoff,rq);

        env = EnvGen.ar(Env.adsr(0.002,0.1,1.0,0.2),gate,doneAction:2);

        Out.ar(out,Pan2.ar(filter*env*amp,pan));

}).add;


SynthDef(\synthdistortion, {|out =0 gate= 1|
        var source = In.ar(out,2);
        var env = Linen.kr(gate, 0.0, 1, 0.1, 2);
        var abs, excess,output;

        abs = source.abs;

        excess = (abs-0.1).max(0.0).min(0.9)/0.9;

        //original plus sinusoidal perturbation of amount based on absolute amplitude
        output = source+(excess*(sin(excess*2pi*5)*0.5-0.5));

        XOut.ar(out,env,output*env);

}).add;

)


//quite loud, be careful
(
Pfx(
        Pbind(
                \instrument,\ressquares,
                \midinote,Pseq([12,0,0,0,3,0,7,0]+36,inf),
                \dur,0.25,
                \amp,Pstutter(8,Pn(Pseries(0.2,0.08,8),inf)),
                \cutoff,Pstutter(8,Pn(Pseries(100,125,11),inf)),
                \rq,Pstutter(4,Pn(Pseries(0.2,-0.02,9),inf)),
                \pan,-0.1
        ),
        \synthdistortion
).play
)








//pp. 48-9

(
SynthDef(\pwmbling,{|out= 0 freq = 440 amp = 0.1 gate=1 lforate = 4.85 lfowidth= 0.5 cutoff= 12000 rq=0.25 pan = 0.0|

        var lfo, pulse, filter, env;
        var basefreq =  ((freq.cpsmidi)+[0,12.12]).midicps;

        lfo = LFTri.kr(lforate*[1,1.01],Rand(0,2.0)!2);

        pulse = Pulse.ar(basefreq,lfo*lfowidth+0.5);

        env = EnvGen.ar(Env.adsr(0.0,1.0,0.2,1.5),gate,doneAction:2);

        filter = RLPF.ar(pulse,(cutoff*(env.squared))+100,rq);

        Out.ar(out,Pan2.ar(Mix(filter)*env*amp,pan));

}).add
)


(
Pbind(
        \instrument,\pwmbling,
        \midinote,Prand([0,1,3,5,6,7,10]+60,inf),
        \dur,Pwrand([0.25,0.5],[0.92,0.08],inf),
        \lfowidth,Pn(Pseries(0.0,0.07,7),inf),
        \cutoff,Pstutter(8,Pn(Pseries(10000,-1000,9),inf))
).play
)







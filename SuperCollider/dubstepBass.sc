//Dubstep bass in SuperCollider, improveable:

//s.boot
(

{
    var trig, note, son, sweep;

    trig = CoinGate.kr(0.5, Impulse.kr(2));

	note = Demand.kr(trig, 0, Dseq((22,24..44).midicps.scramble, inf));
    sweep = LFSaw.ar(Demand.kr(trig, 0, Drand([1, 2, 2, 3, 4, 5, 6, 8, 16], inf))).exprange(40, 5000);

    son = LFSaw.ar(note * [0.99, 1, 1.01]).sum;
	//son = LPF.ar(son, sweep);   
    son = Normalizer.ar(son);
    son = son + BPF.ar(son, 2000, 2);

	//    son = Select.ar(TRand.kr(trig: trig) < 0.05, [son, HPF.ar(son, 1000) * 4]);
	//    son = Select.ar(TRand.kr(trig: trig) < 0.05, [son, HPF.ar(son, sweep) * 4]);
	//    son = Select.ar(TRand.kr(trig: trig) < 0.05, [son, son.round(0.1)]);
    //son = son + GVerb.ar(son, 10, 0.1, 0.7, mul: 0.3);
    0.05*son.dup
}.play

)

(
{
        var trig, note, son, sweep, bassenv, bd, sd, swr;
       
     trig = Impulse.kr(1);
       
        note = Demand.kr(trig, 0, Dxrand([29,28,28,28,28,28,27,25].midicps, inf));
       
        swr = Demand.kr(trig, 0, Drand([0.5, 1, 2, 3, 4, 6], inf));
        sweep = LFTri.ar(swr).exprange(40, 3000);
       
        son = LFSaw.ar(note * [0.99, 1, 1.01]).sum;
        son = LPF.ar(son, sweep);
        son = Normalizer.ar(son);
        son = son + BPF.ar(son, 1500, 2);
       
        //////// special flavours:
        // hi manster
        son = Select.ar(TRand.kr(trig: trig) < 0.4, [son, HPF.ar(son, 2000) * 4]);
        // sweep manster
        son = Select.ar(TRand.kr(trig: trig) < 0.3, [son, HPF.ar(son,
sweep*1.5) * 4]);
        // decimate
        son = Select.ar(TRand.kr(trig: trig) < 0.2, [son, son.round(0.1)]);
       
     son = son + GVerb.ar(son, 11, 0.5, 0.7, mul: 0.2);
        son = (son * 2).sin;

     son = son + SinOsc.ar(note,0,LFTri.ar(swr,mul:2,add:1)).tanh;

     bassenv =
Decay.ar(T2A.ar(Demand.kr(Impulse.kr(4),0,Dseq([1,0,0,0,0,0,1,0],inf))),0.7);
     bd = SinOsc.ar(35+(bassenv**4*200),0,7*bassenv).clip2;
     sd = 4*PinkNoise.ar*Decay.ar(Impulse.ar(0.5,0.5),0.4);
     sd = (sd + BPF.ar(4*sd,1000)).clip2;

     ((son*0.5)+bd+sd).tanh;
}.play
) 


(
{
        var trig, note, son, sweep, bassenv, bd, sd, swr, syn;
       
     trig = Impulse.kr(1);
       
        note = Demand.kr(trig, 0, Dxrand([28+12,13+28,28,28,28,28,27,25],
inf)).lag(0.5).midicps;
       
        swr = Demand.kr(trig, 0, Dseq([1, 6, 6, 2, 1, 2, 4, 8, 3, 3], inf));

        sweep = LFTri.ar(swr).exprange(40, 3000);
       
        son = Saw.ar(note * [0.99, 1.01]).sum;
        son = LPF.ar(son, sweep);
        son = Normalizer.ar(son);
        son = son + BPF.ar(son, 1500, 2);
       
        //////// special flavours:
        // sweep manster
        son = Select.ar(TRand.kr(trig: trig) < 0.5, [son, HPF.ar(son,
sweep*0.75) * 4]);
        // hi manster
        son = Select.ar(TRand.kr(trig: trig) < 0.6, [son, HPF.ar(son, 2500) * 4]);
        // decimate
        son = Select.ar(TRand.kr(trig: trig) < 0.4, [son, son.sin *
LFTri.ar(swr*0.5,mul:2,add:1)]);
       
     son = son + GVerb.ar(son, 9, 0.7, 0.7, mul: 0.2);
        son = (son * 1.5).clip2;

     son = son + SinOsc.ar(note,0,LFTri.ar(swr,mul:2,add:1)).tanh;

     bassenv =
Decay.ar(T2A.ar(Demand.kr(Impulse.kr(4),0,Dseq([1,0,0,0,0,0,1,0,
1,0,0,1,0,0,0,0],inf))),0.7);
     bd = SinOsc.ar(40+(bassenv**3*200),0,7*bassenv).clip2;
     sd =
3*PinkNoise.ar(1!2)*Decay.ar(Impulse.ar(0.5,0.5),[0.4,2],[1,0.05]).sum;
     sd = (sd + BPF.ar(4*sd,2000)).clip2;

     syn =
LeakDC.ar(GVerb.ar(BPF.ar(Splay.ar({Saw.ar(100.0.rand+300+LFNoise1.kr(0.1,10),mul:LFNoise1.kr(0.2))}!12),1000),4,20,drylevel:0)).sin*0.4;

     ((son*0.5)+bd+sd+syn).tanh;
}.play
) 




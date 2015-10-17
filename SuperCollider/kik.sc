// =====================================================================
// Kik Drum
// =====================================================================
(

 SynthDef(\kik, { |basefreq = 27.5, ratio = 7, sweeptime = 0.05, preamp = 1, amp = 2,
       decay1 = 0.3, decay1L = 0.8, decay2 = 0.15, out|

       var       fcurve = EnvGen.kr(Env([basefreq * ratio, basefreq], [sweeptime], \exp)),
       env = EnvGen.kr(Env([1, decay1L, 0], [decay1, decay2], -4), doneAction: 2),
       sig = SinOsc.ar(fcurve, 0.5pi, preamp).distort * env * amp;
     Out.ar(out, sig ! 2)
       }).store;

 )
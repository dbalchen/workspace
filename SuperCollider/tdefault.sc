// =====================================================================
// SuperCollider Workspace
// =====================================================================

SynthDef(\tdefault, { arg out=0, freq=440, amp=0.1, pan=0, gate=1;
var z;
z = LPF.ar(
Mix.new(VarSaw.ar(freq + [0, Rand(-0.4,0.0), Rand(0.0,0.4)], 0, 0.3, 0.3)),
XLine.kr(Rand(4000,5000), Rand(2500,3200), 1)
) * Linen.kr(gate, 0.01, 0.7, 0.3, 2);
OffsetOut.ar(out, Pan2.ar(z, pan, amp));
}).store;

SynthDef(\tdefault, { arg out=0, freq=440, amp=1, pan=0, gate=1;
var z,env,sweep,son;

env = Env.perc(0.001,0.2,1,-4);
env = EnvGen.kr(env,gate,doneAction:2);
z = LPF.ar(
Mix.new(VarSaw.ar(freq + [0, Rand(-0.4,0.0), Rand(0.0,0.4)], 0, 0.3, 0.3)),
XLine.kr(Rand(4000,5000), Rand(2500,3200), 1)
) * env;

OffsetOut.ar(out, Limiter.ar(100*Pan2.ar(z.abs, pan, amp),0.1, 0.01) );
}).store;


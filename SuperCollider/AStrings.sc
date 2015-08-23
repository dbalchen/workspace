Help.gui
Quarks.gui


s = JStethoscope.defaultServer.boot;
JFreqScope.new( 400, 200, 0 );

// Analog Strings
(
SynthDef("aStrings",{arg freq = 440,gate = 0, out = 0, lpf = 1470, spread = 10.00;
var sig, sig2, sig3, sig4,sig5,vib,cent1, cent2, cent3, env,cent4, wobble,yaw,x;

    env = Env.asr(0.5,1,1, 1);
    env = EnvGen.kr(env, gate,doneAction:2);
    //freq = { freq * LFNoise2.kr(1,0.01,1) }!24; 
    cent1 = 2**(spread/1200);
    cent2 = 2**((spread*0.76543)/1200);
    cent3 = 2**((spread*0.3333)/1200);
    cent4 = 2**((spread*0.25)/1200);

    wobble = freq*((2**(spread/1200)) - 1);
    yaw = 10;
    vib = wobble*SinOsc.kr((yaw));

    sig =  LFSaw.ar(vib + (freq));
    sig2 = LFSaw.ar(vib + (freq*cent1));
    sig3 = LFSaw.ar(vib + (freq/(cent2)));
    sig4 = LFSaw.ar(vib + (freq*(cent3)));
    sig5 = LFSaw.ar(vib + (freq/cent4));

    x = Mix.new([sig/5,sig2/5,sig3/5,sig4/5,sig5/5]);
    x = LPF.ar(env*x,lpf);
    x = FreeVerb.ar( x, 0.7, 0.5, 0.5 );
	Out.ar ( out,x.dup);
}
).store;
)
// Quick Test
       x = Synth("cStrings");
       x.set(\gate,1);
       x.set(\freq,880);
       x.set(\gate,0);

// Gui Test
x = SynthDefAutogui(\aStrings, onInit: false) ;
x.autogui ; // the autogui method actually creates the gui
x.controlArr(\gate,1);





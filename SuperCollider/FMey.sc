// =====================================================================
// SuperCollider Workspace
// =====================================================================

(
SynthDef("preDelay", { arg inbus = 2;
        ReplaceOut.ar(
                4,
                DelayN.ar(In.ar(inbus, 1), 0.048, 0.048)
        )
}).add;

SynthDef("combs", {
        ReplaceOut.ar(
                6,
                Mix.arFill(7, { CombL.ar(In.ar(4, 1), 0.1, LFNoise1.kr(Rand(0, 0.1), 0.04, 0.05), 15) })
        )
}).add;

SynthDef("allpass", { arg gain = 0.2;
        var source;
        source = In.ar(6, 1);
        4.do({ source = AllpassN.ar(source, 0.050, [Rand(0, 0.05), Rand(0, 0.05)], 1) });
        ReplaceOut.ar(
                8,
                source * gain
        )
}).add;

SynthDef("theMixer", { arg gain = 1;
        ReplaceOut.ar(
                0,
                Mix.ar([In.ar(2, 1), In.ar(8, 2)]) * gain
        )
}).add;
)

(
Synth("fm1", [\bus, 2, \freq, 440, \carPartial, 1, \modPartial, 1.99, \mul, 0.071]);
Synth("fm1", [\bus, 2, \freq, 442, \carPartial, 1, \modPartial, 2.401, \mul, 0.071]);
Synth.tail(s, "preDelay");
Synth.tail(s, "combs");
Synth.tail(s, "allpass");
Synth.tail(s, "theMixer", [\gain, 0.64]);
)

(
s.queryAllNodes;
)


(
SynthDef("carrier", { arg inbus = 2, outbus = 0, freq = 440, carPartial = 1, index = 3, mul = 0.2;

        // index values usually are between 0 and 24
        // carPartial :: modPartial => car/mod ratio

        var mod;
        var car;

        mod = In.ar(inbus, 1);

        Out.ar(
                outbus,
                SinOsc.ar((freq * carPartial) + mod, 0, mul);
        )
}).add;

SynthDef("modulator", { arg outbus = 2, freq, modPartial = 1, index = 3;
        Out.ar(
                outbus,
                SinOsc.ar(freq * modPartial, 0, freq)
                *
                LFNoise1.kr(Rand(3, 6).reciprocal).abs
                *
                index
        )
}).add;
)

(
var freq = 440;
// modulators for the left channel
Synth.head(s, "modulator", [\outbus, 2, \freq, freq, \modPartial, 0.649, \index, 2]);
Synth.head(s, "modulator", [\outbus, 2, \freq, freq, \modPartial, 1.683, \index, 2.31]);

// modulators for the right channel
Synth.head(s, "modulator", [\outbus, 4, \freq, freq, \modPartial, 0.729, \index, 1.43]);
Synth.head(s, "modulator", [\outbus, 4, \freq, freq, \modPartial, 2.19, \index, 1.76]);

// left and right channel carriers
Synth.tail(s, "carrier", [\inbus, 2, \outbus, 0, \freq, freq, \carPartial, 1]);
Synth.tail(s, "carrier", [\inbus, 4, \outbus, 1, \freq, freq, \carPartial, 0.97]);
)


(
var freq;
// generate a random base frequency for the carriers and the modulators
w = Window.new("FM-ey", Rect(200, Window.screenBounds.height-700,1055,600)).front ;

~freq = 330.0.rrand(500);

// modulators for the left channel
Synth.head(s, "modulator", [\outbus, 60, \freq, ~freq, \modPartial, 0.649, \index, 2]).autogui(window:w, step:50, vOff: 0, hOff:0, scopeOn:false) ;
Synth.head(s, "modulator", [\outbus, 60, \freq, ~freq, \modPartial, 1.683, \index, 2.31]).autogui(window:w, step:50, vOff:0, hOff:350, scopeOn:false) ;

// modulators for the right channel
Synth.head(s, "modulator", [\outbus, 62, \freq, freq, \modPartial, 1.11, \index, 1.43]).autogui(window:w, step:50, vOff:200, hOff:0, scopeOn:false) ;
Synth.head(s, "modulator", [\outbus, 62, \freq, freq, \modPartial, 0.729, \index, 1.76]).autogui(window:w, step:50, vOff: 200, hOff:350, scopeOn:false) ;

// left and right channel carriers
Synth.tail(s, "carrier", [\inbus, 60, \outbus, 100, \freq, ~freq, \carPartial, 1]).autogui(window:w, step:50, vOff: 400, hOff:0, scopeOn:false) ;
Synth.tail(s, "carrier", [\inbus, 62, \outbus, 100, \freq, ~freq+1, \carPartial, 2.91]).autogui(window:w, step:50, vOff: 400, hOff:350, scopeOn:false) ;

Synth.tail(s, "preDelay", [\inbus, 100]);
Synth.tail(s, "combs");
Synth.tail(s, "allpass");
Synth.tail(s, "theMixer", [\gain, 0.2]);

//Synth(\Bank1).autogui(window:w, step:50, vOff: 0, hOff:0, scopeOn:true) ;
//Synth(\Rate, addAction:\addToHead).autogui(window:w, step:50, vOff: 0, hOff:830, scopeOn:false) ;
//Synth(\Bank2, addAction:\addToTail).autogui(window:w, step:50, vOff: 200, hOff:0, scopeOn:false) ;
//Synth(\Filter, addAction:\addToTail).autogui(window:w, step:50, vOff: 400, hOff:0, scopeOn:false) ;
//Synth(\Output, addAction:\addToTail).autogui(window:w, step:50, vOff: 400, hOff:360, scopeOn:false) ;
)

(

{

var freq = 440; // main frequency

var cmrat = 1.01; // modulator to carrier ratio

var index = 20.0 * freq; // set basic index relative to frequency

var outsound = 0; // output signal

var feedbackmod; // the feedback phase modulation term

var feed_delay_time = 0.01; // add a small delay to output signal

var delfeed; // delay the feedback signal

var feedback_index; // vary the index of feedback modulation



	//feedback_index = LFNoise1.ar(0.3, 0.5, 0.5);

feedback_index = MouseX.kr(0,1);

feedbackmod = LocalIn.ar(1) * feedback_index ;

delfeed = DelayN.ar(feedbackmod, feed_delay_time, feed_delay_time) * index;

outsound = SinOsc.ar( freq + delfeed, 0, 0.1);

LocalOut.ar( outsound );

outsound ! 2; // force stereo output

}.play

)



(

{

var freq = 440; // main frequency

var cmrat = 1.01; // modulator to carrier ratio

var index = 20.0 * freq; // set basic index relative to frequency

var outsound = 0; // output signal

var feedbackmod; // the feedback phase modulation term

var feed_delay_time = 0.01; // add a small delay to output signal

var delfeed; // delay the feedback signal

var feedback_index; // vary the index of feedback modulation



	//feedback_index = LFNoise1.ar(0.3, 0.5, 0.5);

feedback_index = MouseX.kr(0,1);

feedbackmod = LocalIn.ar(1) * feedback_index ;

delfeed = DelayN.ar(feedbackmod, feed_delay_time, feed_delay_time) * index;

outsound = SinOsc.ar( freq + delfeed, 0, 0.1);

LocalOut.ar( outsound );

outsound ! 2; // force stereo output

}.play

)



Synth(\Bank1).autogui(window:w, step:50, vOff: 0, hOff:0, scopeOn:true) ;
Synth(\Rate, addAction:\addToHead).autogui(window:w, step:50, vOff: 0, hOff:830, scopeOn:false) ;
Synth(\Bank2, addAction:\addToTail).autogui(window:w, step:50, vOff: 200, hOff:0, scopeOn:false) ;
Synth(\Filter, addAction:\addToTail).autogui(window:w, step:50, vOff: 400, hOff:0, scopeOn:false) ;
Synth(\Output, addAction:\addToTail).autogui(window:w, step:50, vOff: 400, hOff:360, scopeOn:false) ;

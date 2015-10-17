// =====================================================================
// SuperCollider Workspace
// =====================================================================

// Brad's first attempt at an SC3 app-thingy.  Yeah, I know, everyone
// builds a granular synth thing, but it was a true Learning Experience.
// click-select from the "(" below and it should load and run ok.
//
// As with all gran-synth apps, be careful of your grain rate coupled
// with the grain dur, it's easy to really soak the processor.
//
//	-- BGG 3/2003
// 
// -- modified for SC3.3/3.4, 2/2011


(
var s, w, b, c, nchans, nframes, buf, buftext, bufenter, soundbutt, soundtext, gotext, gobutt,
	rateslide, ratetext, ratelo, ratehi,
	durslide, durtext, durlo, durhi,
	pchslide, pchtext, pchlo, pchhi,
	posslide, postext, poslo, poshi,
	locslide, loctext, loclo, lochi, locspread,
	speedslide, speedtext, speed;

s = Server.local;
if (s.serverRunning == false, { s.boot; });


SynthDef("plbuf1", { arg trig = 1, start = 0, gdur = 0.05, prate = 1.0, pos = 0.5, bno = 0;
	var out, e, amp, c1, c2;
	e = Env.triangle(dur: gdur, level: 1.0);
	amp = EnvGen.ar(e, doneAction: 2);
	out = PlayBuf.ar(1, bno, prate, trig, startPos: start, loop: 0);
	c1 = out*amp*pos;
	c2 = out*amp*(1.0-pos);
	Out.ar(0, [c1, c2]);
	}).load(s);


SynthDef("plbuf2", { arg trig = 1, start = 0, gdur = 0.05, prate = 1.0, pos = 0.5, bno = 0;
	var out, e, amp, c1, c2;
	e = Env.triangle(dur: gdur, level: 1.0);
	amp = EnvGen.ar(e, doneAction: 2);
	out = PlayBuf.ar(2, bno, prate, trig, startPos: start, loop: 0);
	c1 = out.at(0)*amp*pos;
	c2 = out.at(1)*amp*(1.0-pos);
	Out.ar(0, [c1, c2]);
	}).load(s);
	

ratelo = 0.2;
ratehi = 0.21;
durlo = 0.04;
durhi = 0.06;
pchlo = 1.0;
pchhi = 1.0;
poslo = 0.5;
poshi = 0.5;
loclo = 0.1;
lochi = 0.2;
locspread = 0.1;
speed = 0.005;
buf = 0;

w = Window("hi there!", Rect(100, 500, 300, 425));

soundtext = StaticText(w, Rect(30,5, 60,20));
	soundtext.font = Font("Helvetica", 10);
	soundtext.stringColor = Color.blue;
	soundtext.align = \center;
	soundtext.string = "soundfile";
	
soundbutt = Button(w, Rect(30,30, 60, 20));
	soundbutt.states = [
		["load", Color.black, Color.new(0.0, 0.5, 0.9)],
		];
	soundbutt.action = { arg view;
		buf = bufenter.value; // get the value of the current buffer
		File.openDialog("hey hey hey", { arg path; var sf;
			sf = SoundFile.new;
			sf.openRead(path);
			nchans = sf.numChannels;
			nframes = sf.numFrames;
			sf.close;
			s.sendMsg("/b_allocRead", buf, path, 0, nframes);
			gobutt.enabled = true;
			});	
		};


buftext = StaticText(w, Rect(120,5, 60,20));
	buftext.font = Font("Helvetica", 10);
	buftext.stringColor = Color.blue;
	buftext.align = \center;
	buftext.string = "buffer #";


bufenter = NumberBox(w, Rect(140,30, 20,20));
	bufenter.align = \center;
	bufenter.setProperty(\background, Color.new(0.8, 0.5, 0.9));
	bufenter.value = 0;

gotext = StaticText(w, Rect(210,5, 70,20));
	gotext.font = Font("Helvetica", 10);
	gotext.stringColor = Color.blue;
	gotext.align = \center;
	gotext.string = "granulatarize...";
	
	gobutt = Button(w, Rect(210,30, 60, 20));
	gobutt.states = [
		["GO!", Color.black, Color.new(0.0, 0.5, 0.9)],
		["nomore!", Color.white, Color.new(0.8, 0.5, 0.9)],
		];
	gobutt.action = { arg view;
		if (gobutt.value == 1, {
			b = Routine({
			loop ({
				if (nchans == 1, {
					Synth("plbuf1", ["start", rrand(loclo, lochi)*(nframes-												(durhi*(44100*pchhi))),
						"gdur", rrand(durlo, durhi),
						"prate", rrand(pchlo, pchhi),
						"pos", rrand(poslo, poshi),
						"bno", buf]);
				},{
					Synth("plbuf2", ["start", rrand(loclo, lochi)*(nframes-												(durhi*(44100*pchhi))),
					"gdur", rrand(durlo, durhi),
					"prate", rrand(pchlo, pchhi),
					"pos", rrand(poslo, poshi),
					"bno", buf]);
				});
				rrand(ratelo, ratehi).wait;
				})
			}).play;
			c = Routine({
			loop ({
				0.01.wait;
				loclo = loclo + speed;
				lochi = lochi + speed;
				if (lochi > 1.0, {
					loclo = 0.0;
					lochi = loclo+locspread;
					});
				if (loclo < 0.0, {
					lochi = 1.0;
					loclo = lochi-locspread;
					});
				locslide.setProperty(\lo, loclo);
				locslide.setProperty(\hi, lochi);
				});
			});
			AppClock.play(c);
		},{
			b.stop;
			c.stop;
		});
	};
	gobutt.enabled = false;

ratetext = StaticText(w, Rect(10,60, 90,20));
	ratetext.font = Font("Helvetica", 10);
	ratetext.stringColor = Color.blue;
	ratetext.align = \left;
	ratetext.string = "grain rate";
	
rateslide = RangeSlider(w, Rect(10,85, 280,20));
	rateslide.lo = ratelo+0.01;
	rateslide.hi = ratehi+0.01;
	rateslide.action = { arg slider;
		ratelo = rateslide.lo+0.0025;
		ratehi = rateslide.hi+0.0025;
		//the "ratelo" multiplier protects a bit against CPU overload
		durlo = (durslide.lo+0.0025)*(ratelo*10.0);
		durhi = (durslide.hi+0.0025)*(ratelo*10.0);
		};

durtext = StaticText(w, Rect(10,120, 90,20));
	durtext.font = Font("Helvetica", 10);
	durtext.stringColor = Color.blue;
	durtext.align = \left;
	durtext.string = "grain duration";
	
durslide = RangeSlider(w, Rect(10,145, 280,20));
	durslide.lo = durlo+0.01;
	durslide.hi = durhi+0.01;
	durslide.action = { arg slider;
		//the "ratelo" multiplier protects a bit against CPU overload
		durlo = (durslide.lo+0.0025)*(ratelo*10.0);
		durhi = (durslide.hi+0.0025)*(ratelo*10.0);
		};

pchtext = StaticText(w, Rect(10,180, 90,20));
	pchtext.font = Font("Helvetica", 10);
	pchtext.stringColor = Color.blue;
	pchtext.align = \left;
	pchtext.string = "pitch variance";
	
pchslide = RangeSlider(w, Rect(10,205, 280,20));
	pchslide.lo = pchlo/2.0;
	pchslide.hi = pchhi/2.0;
	pchslide.action = { arg slider;
		pchlo = (pchslide.lo*2.0);
		pchhi = (pchslide.hi*2.0);
		};

postext = StaticText(w, Rect(10,240, 90,20));
	postext.font = Font("Helvetica", 10);
	postext.stringColor = Color.blue;
	postext.align = \left;
	postext.string = "stereo variance";
	
posslide = RangeSlider(w, Rect(10,265, 280,20));
	posslide.lo = poslo;
	posslide.hi = poshi;
	posslide.action = { arg slider;
		poslo = posslide.lo;
		poshi = posslide.hi;
		};

loctext = StaticText(w, Rect(10,300, 90,20));
	loctext.font = Font("Helvetica", 10);
	loctext.stringColor = Color.blue;
	loctext.align = \left;
	loctext.string = "playback location";
	
locslide = RangeSlider(w, Rect(10,325, 280,20));
	locslide.lo = loclo;
	locslide.hi = lochi;
	locslide.action = { arg slider;
		loclo = locslide.lo;
		lochi = locslide.hi;
		locspread = lochi-loclo;
		};

speedtext = StaticText(w, Rect(10,360, 90,20));
	speedtext.font = Font("Helvetica", 10);
	speedtext.stringColor = Color.blue;
	speedtext.align = \left;
	speedtext.string = "playback speed";
	
speedslide = Slider(w, Rect(10,385, 280,20));
	speedslide.value = (speed/0.05)+0.5;
	speedslide.action = { arg slider;
		speed = (speedslide.value-0.5)*0.05;
		};
	

w.front;
)




s.boot;

(
var winenv;

b = Buffer.readChannel(s,"/home/dbalchen/Music/Samples/SonatinaSymphonicOrchestra/Samples/Cor Anglais/cor_anglais-g#3.wav",channels: [0]);
// a custom envelope
winenv = Env([0, 1, 0], [0.5, 0.5], [8, -8]);
z = Buffer.sendCollection(s, winenv.discretize, 1);

SynthDef(\buf_grain_test, {arg gate = 1, amp = 1, sndbuf, envbuf;
    var pan, env, freqdev;
    // use mouse x to control panning
    pan = MouseX.kr(-1, 1);
    env = EnvGen.kr(
        Env([0, 1, 0], [1, 1], \sin, 1),
        gate,
        levelScale: amp,
        doneAction: 2);
    Out.ar(0,
        GrainBuf.ar(2, Impulse.kr(10), 0.1, sndbuf, LFNoise1.kr.range(0.5, 2),
            LFNoise2.kr(0.1).range(0, 1), 2, pan, envbuf) * env)
    }).send(s);

)

// use built-in env
x = Synth(\buf_grain_test, [\sndbuf, b, \envbuf, -1])

// switch to the custom env
x.set(\envbuf, z)
x.set(\envbuf, -1);

x.set(\gate, 0);



~pulseSweep = {

	~circleExtOut = Bus.control(s,1);
	~circleExt.set(\gate,0);
	~circleExt = nil;
	~circleExt = Synth("myExtCircle",addAction: \addToHead);
	~circleExt.set(\start,0.9);
	~circleExt.set(\out,~circleExtOut);
	~circleExt.set(\mull,0.5);
	~circleExt.set(\sig2p,((8*4)/2));
	~circleExt.set(\time,((32*4)/2));
	~mixer3.set(\bmod,~circleExtOut);
	~mixer3.set(\bal,0);
	~circleExt.set(\gate,1); };

~pulseSweepOff = {

	~circleExt.set(\gate,0);
	~circleExt = nil;
	~mixer3.set(\bmod,999);
	~mixer3.set(\bal,0.80);

};


~noiseSweep = {

	~circleExt2Out = Bus.control(s,1);
	~circleExt2.set(\gate,0);
	~circleExt2 = nil;
	~circleExt2 = Synth("myExtCircle",addAction: \addToHead);
	~circleExt2.set(\start,1);
	~circleExt2.set(\end,-1);
	~circleExt2.set(\out,~circleExt2Out);
	~circleExt2.set(\mull,0.25);
	~circleExt2.set(\sig2p,((8*4)/2));
	~circleExt2.set(\time,((24*4)/2));
	~mixer2.set(\bmod,~circleExt2Out);
	~mixer2.set(\bal,0);
	~circleExt2.set(\gate,1); };


~noiseSweep2 = {

	~circleExt3Out = Bus.control(s,1);
	~circleExt3.set(\gate,0);
	~circleExt3 = nil;
	~circleExt3 = Synth("myExtCircle",addAction: \addToHead);
	~circleExt3.set(\start,1);
	~circleExt3.set(\end,-0.5);
	~circleExt3.set(\out,~circleExt3Out);
	~circleExt3.set(\mull,0.5);
	~circleExt3.set(\sig2p,((8*4)/2));
	~circleExt3.set(\time,((24*4)/2));
	~mixer1.set(\bmod,~circleExt3Out);
	~mixer1.set(\bal,0);
	~circleExt3.set(\gate,1); };


~pulseAmp = {arg start = 0, end = 1;

	~circleExt4Out = Bus.control(s,1);
	~circleExt4.set(\gate,0);
	~circleExt4 = nil;
	~circleExt4 = Synth("myExtCircle",addAction: \addToHead);
	~circleExt4.set(\start,start);
	~circleExt4.set(\end,end);
	~circleExt4.set(\out,~circleExt4Out);
	~circleExt4.set(\mull,0.05);
	~circleExt4.set(\sig2p,((8*4)/2));
	~circleExt4.set(\time,((16*4)/2));
	~circleExt4.set(\gate,1); };


~sineAmp = {arg start = 0, end = 0.5;

	~circleExt5Out = Bus.control(s,1);
	~circleExt5.set(\gate,0);
	~circleExt5 = nil;
	~circleExt5 = Synth("myExtCircle",addAction: \addToHead);
	~circleExt5.set(\start,start);
	~circleExt5.set(\end,end);
	~circleExt5.set(\out,~circleExt5Out);
	~circleExt5.set(\mull,0.15);
	~circleExt5.set(\sig2p,((8*4)/2));
	~circleExt5.set(\time,((16*4)/2));
	~circleExt5.set(\gate,1); };



~stringSweep = {

	~circleExt6Out = Bus.control(s,1);
	~circleExt6.set(\gate,0);
	~circleExt6 = nil;
	~circleExt6 = Synth("myExtCircle",addAction: \addToHead);
	~circleExt6.set(\start,-1);
	~circleExt6.set(\end,1);
	~circleExt6.set(\out,~circleExt6Out);
	~circleExt6.set(\mull,0.5);
	~circleExt6.set(\sig2p,((16*4)/2));
	~circleExt6.set(\time,((64*4)/2));
	~mixer4.set(\bmod,~circleExt6Out);
	~mixer4.set(\bal,0);
	~circleExt6.set(\gate,1); };




~modCircle = {arg out, start = 0, end = 1, time = 4, time2 = 4, mult = 1;
	var mod;
	mod  = Synth("myExtCircle",addAction: \addToHead);
	mod.set(\start,start);
	mod.set(\end,end);
	mod.set(\out,out);
	mod.set(\mull,mult);
	mod.set(\sig2p,time2);
	mod.set(\time,time);
	mod;
};


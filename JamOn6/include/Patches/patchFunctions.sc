~pulseSweep = {arg start = 0.9, end = -1, time = ((32*4)/2), time2 = ((8*4)/2), mult = 0.5;

	~circleExtOut = Bus.control(s,1);
	~circleExt = ~modCircle.value(~circleExtOut,start,end,time,time2,mult);
	~mixer3.set(\bmod,~circleExtOut);
	~mixer3.set(\bal,0);
	~circleExt.set(\gate,1); };

~pulseSweepOff = {

	~circleExt.set(\gate,0);
	~circleExt = nil;
	~mixer3.set(\bmod,999);
	~mixer3.set(\bal,0.80);
};


~noiseSweep = {arg start = -1, end = 1, time = ((24*4)/2), time2 = ((8*4)/2), mult = 0.25;

	~circleExt2Out = Bus.control(s,1);
	~circleExt2 = ~modCircle.value(~circleExt2Out,start,end,time,time2,mult);
	~mixer2.set(\bmod,~circleExt2Out);
	~mixer2.set(\bal,0);
	~circleExt2.set(\gate,1); };

~noiseSweepOff = {

	~circleExt2.set(\gate,0);
	~circleExt2 = nil;
	~mixer2.set(\bmod,999);
	~mixer2.set(\bal,0.80);
};

~noiseSweep2 = {arg start = -1, end = 1, time = ((24*4)/2), time2 = ((8*4)/2), mult = 0.05;

	~circleExt3Out = Bus.control(s,1);
	~circleExt3 = ~modCircle.value(~circleExt3Out,start,end,time,time2,mult);
	~mixer1.set(\bmod,~circleExt3Out);
	~mixer1.set(\bal,0);
	~circleExt3.set(\gate,1); };
	
~noiseSweep2Off = {

	~circleExt3.set(\gate,0);
	~circleExt3 = nil;
	~mixer1.set(\bmod,999);
	~mixer1.set(\bal,0.80);
};


~pulseAmp = {arg start = 0, end = 1, time = ((16*4)/2), time2 = ((8*4)/2), mult = 0.05;

	~circleExt4Out = Bus.control(s,1);
	~circleExt4 = ~modCircle.value(~circleExt4Out,start,end,time,time2,mult);
	~circleExt4.set(\gate,1); };


~sineAmp = {arg out, start = 0, end = 1, time = ((16*4)/2), time2 = ((8*4)/2), mult = 0.15;

	~circleExt5Out = Bus.control(s,1);
        ~circleExt5 = ~modCircle.value(~circleExt5Out,start,end,time,time2,mult);
	~circleExt5.set(\gate,1); };



~stringSweep = {arg out, start = -1, end = 1, time = ((64*4)/2), time2 = ((16*4)/2), mult = 0.5;

	~circleExt6Out = Bus.control(s,1);
	~circleExt6 = ~modCircle.value(~circleExt6Out,start,end,time,time2,mult);
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


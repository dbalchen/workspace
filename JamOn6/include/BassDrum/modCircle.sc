
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


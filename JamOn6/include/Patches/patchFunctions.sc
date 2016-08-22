~pulseSweep = {

	~circleExtOut = Bus.control(s,1);
	~circleExt.set(\gate,0);
	~circleExt = nil;
	~circleExt = Synth("myExtCircle",addAction: \addToHead);
	~circleExt.set(\start,0.9);
	~circleExt.set(\out,~circleExtOut);
	~circleExt.set(\mull,0.5);
	~circleExt.set(\sig2p,(8*4*2));
	~circleExt.set(\time,(32*4*2));
	~mixer3.set(\bmod,~circleExtOut);
	~mixer3.set(\bal,0);
	~circleExt.set(\gate,1); };

~pulseSweepOff = {

	~circleExt.set(\gate,0);
	~circleExt = nil;
	~mixer3.set(\bmod,999);
	~mixer3.set(\bal,0.90);

};
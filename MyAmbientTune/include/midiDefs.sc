~channel0 = {arg num, vel = 1;
	var ret;
	num.postln;

	ret = Synth("stringLow");
	ret.set(\num,num);
	ret.set(\gate,1);

	ret;
};

~channel0off = {arg num, vel = 1;
	var ret = nil;

	~stringLow_env.set(\gate,0);
	~stringLow_fenv.set(\gate,0);
	~string_low_synth.set(\gate,0);
	ret;
};


~turndown1 = {
	arg vol,cc,chan,src;
	vol = vol/127;
	vol.postln;

	if((chan == 0), {
		~lowStrings.amp = vol;

	});

	if((chan == 1), {

	});

	if((chan == 2), {



	});

	if((chan == 3), {


	});

	if((chan == 4), {


	});

	if((chan == 5), {


	});

	if((chan == 6), {


	});

	if((chan == 7), {


	});

	if((chan == 8), {


	});
	if((chan == 9), {


	});

	if((chan == 10), {

	});

	if((chan == 11), {


	});

	if((chan == 12), {

	});

	if((chan == 13), {


	});

	if((chan == 14), {


	});

	if((chan == 15), {


	});


};

~volCC.free;
~volCC = MIDIdef.cc(\volume, ~turndown1, 7);

~pan1 = {
	arg vol,cc,chan,src;
	vol = (2*(vol/127))-1;

	vol.postln;

	if((chan == 0), {

		~lowStrings.balance = vol;
	});

	if((chan == 1), {

	});

	if((chan == 2), {


	});

	if((chan == 3), {

	});

	if((chan == 4), {

	});

	if((chan == 5), {


	});

	if((chan == 6), {


	});

	if((chan == 7), {


	});

	if((chan == 8), {


	});
	if((chan == 9), {


	});

	if((chan == 10), {
	});

	if((chan == 11), {


	});

	if((chan == 12), {

	});

	if((chan == 13), {


	});

	if((chan == 14), {


	});

	if((chan == 15), {


	});

};

~ballCC.free;
~balCC = MIDIdef.cc(\pan, ~pan1,10); // match cc 1



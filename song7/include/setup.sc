
~midiSetup = {
	var inPorts = 1;
	var outPorts = 4;

	MIDIClient.disposeClient;
	MIDIClient.init(inPorts,outPorts); // explicitly intialize the client
	inPorts.do({ arg i;
		MIDIIn.connect(i, MIDIClient.sources.at(i));
	});
};

~midiSetup.value;

~out0 = MIDIOut(0);
~out0.latency = 0;

~out1 = MIDIOut(1);
~out1.latency = 0;

~out2 = MIDIOut(2);
~out2.latency = 0;

~out3 = MIDIOut(3);
~out3.latency = 0;

~displayCC.free;
~displayCC = MIDIdef.cc(\displayCC, {arg ...args; args.postln}); // display CC


t = TempoClock.default.tempo = 60 / 60;
// =====================================================================
// SuperCollider Workspace
// =====================================================================


t = TempoClock.default.tempo = 120/ 60;

~mytrack = Track.new(~out0,0);

~vca = MyADSR.new(1.5,2.5,0.4,0.75,"VCA");

~vca.gui;

~vcf = MyADSR.new(1.5,2.5,0.4,0.75,"VCF");

~vcf.gui;


~evenVCOpoly = {arg num, vel = 1,src,out = 0;
	var ret,tidx;
	num.postln;
	tidx = (~wavetables.size/120)* num;
	ret = Synth("evenVCO");
	ret.set(\ss,~wavebuff);
	ret.set(\freq,num.midicps);
	ret.set(\idx,tidx);
	~vca.setADSR(ret);
	~vcf.setfADSR(ret);
	ret.set(\out,out);
	ret.set(\gate,1);
	ret.set(\hpf,420);

	ret;
};


~mytrack.noteON = ~evenVCOpoly;

~mynotes = Notes.new;

~mynotes.freqs = [57,59,61,56,52,54,56,57,52,57,59,61,64,66,68,64,61,64,62,64,65,64,62,61,62,64,61,62,61,59,64,59,57,59,52] +12 ;

~mynotes.waits = [1.0,2.0,1.0,3.0,1.0,1.0,2.0,1.0,4.0,1.0,2.0,1.0,3.0,1.0,1.0,2.0,1.0,4.0,1.0,2.0,1.0,3.0,1.0,1.0,2.0,1.0,4.0,1.0,2.0,1.0,4.0,1.0,2.0,1.0,4.0];

~mynotes.init;

~mytrack.notes = ~mynotes;

~mytrack.transport.play;

~tonerow = ~pcset.value(~mynotes.freqs);

~tonerow = (~mynotes.freqs % 12).as(Set).as(Array).sort;

~scale = ~createScale.value(~tonerow);

~key = 9;

~basescale = ~scale - ~key;


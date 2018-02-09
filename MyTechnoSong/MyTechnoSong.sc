Help.gui
Quarks.gui

s.boot;
s.plotTree;
s.meter;
s.quit;

Stethoscope.new(s);
FreqScope.new(800, 400, 0, server: s);
Server.default.makeGui


(
 o = Server.local.options;
 o.numOutputBusChannels = 24; // The next time it boots, this will take effect
 o.memSize = 2097152;
 )

"/home/dbalchen/Music/setup.sc".load;



(
 ~startup = {


   (

    "/home/dbalchen/Music/MyTechnoSong/include/synths/envelopes.sc".load;
    "/home/dbalchen/Music/MyTechnoSong/include/synths/kick.sc".load;
    "/home/dbalchen/Music/MyTechnoSong/include/synths/eStrings.sc".load;
    "/home/dbalchen/Music/MyTechnoSong/include/synths/eSampler.sc".load;

    "/home/dbalchen/Music/MyTechnoSong/include/events/bassDrum.sc".load;
    "/home/dbalchen/Music/MyTechnoSong/include/patch/bassDrum.sc".load;

    "/home/dbalchen/Music/MyTechnoSong/include/events/LowStrings.sc".load;
    "/home/dbalchen/Music/MyTechnoSong/include/patch/LowStrings.scd".load;
     "/home/dbalchen/Music/MyTechnoSong/include/events/viola.sc".load;
    "/home/dbalchen/Music/MyTechnoSong/include/patch/viola.sc".load;
    "/home/dbalchen/Music/MyTechnoSong/include/patch/strings.sc".load;

    ~cello = MyTrack.new(~synth1,1);
	   ~viola = MyTrack.new(~synth1,2);
	   

	   
    ~violin = MyTrack.new(~synth1,3);

    ~string_cello_vca_envelope = MyADSR.new;
    ~string_cello_vca_envelope.init;
    ~string_cello_vca_envelope.attack = 1.5;
    ~string_cello_vca_envelope.decay = 2.5;
    ~string_cello_vca_envelope.sustain = 0.4;
    ~string_cello_vca_envelope.release = 1;

    ~string_cello_vcf_envelope = MyADSR.new;

    ~string_cello_vcf_envelope.init;
    ~string_cello_vcf_envelope.attack = 1.5;
    ~string_cello_vcf_envelope.decay = 2.5;
    ~string_cello_vcf_envelope.sustain = 0.2;
    ~string_cello_vcf_envelope.release = 1;

    ~string_viola_vca_envelope = MyADSR.new;
    ~string_viola_vca_envelope.init;
    ~string_viola_vca_envelope.attack = 1.5;
    ~string_viola_vca_envelope.decay = 2.5;
    ~string_viola_vca_envelope.sustain = 0.4;
    ~string_viola_vca_envelope.release = 0.5;

    ~string_viola_vcf_envelope = MyADSR.new;
    ~string_viola_vcf_envelope.init;
    ~string_viola_vcf_envelope.attack = 1.5;
    ~string_viola_vcf_envelope.decay = 2.5;
    ~string_viola_vcf_envelope.sustain = 0.2;
    ~string_viola_vcf_envelope.release = 0.5;

    ~string_violin_vca_envelope = MyADSR.new;
    ~string_violin_vca_envelope.init;
    ~string_violin_vca_envelope.attack = 1.5;
    ~string_violin_vca_envelope.decay = 2.5;
    ~string_violin_vca_envelope.sustain = 0.4;
    ~string_violin_vca_envelope.release = 1;

    ~string_violin_vcf_envelope = MyADSR.new;
    ~string_violin_vcf_envelope.init;
    ~string_violin_vcf_envelope.attack = 1.5;
    ~string_violin_vcf_envelope.decay = 2.5;
    ~string_violin_vcf_envelope.sustain = 0.2;
    ~string_violin_vcf_envelope.release = 1;

    "/home/dbalchen/Music/MyTechnoSong/include/midiDefs.sc".load

    )

     };
 )

~myadsr.gui
~mixergui.gui

~string_low_vca_envelope.gui
~string_low_vcf_envelope.gui

~string_cello_vca_envelope.gui;
~string_cello_vcf_envelope.gui;



~startup.value;
~startTimer.value(120);

~bassDrum.transport.play;~bassDrumNotes.transport.play;
~bassDrum.transport.stop;

~rp = {~lowStrings.transport.play;};
~rp = {~viola2.transport.play;};

~rp = {~bassDrum.transport.play;~bassDrumNotes.transport.play;}; // Example


~rp = {~viola2.transport.play;~lowStrings.transport.play;~bassDrum.transport.play;~bassDrumNotes.transport.play;}; // Example

(
 ~start = {

   var num = 60,timeNow;
   t = TempoClock.default.tempo = num / 60;

   Routine.run({
       s.sync;
       timeNow = TempoClock.default.beats;

       t.schedAbs(timeNow + 00,{ // 00 = Time in beats
	   (
	    // If yes put stuff Here
			);

	   (
	    // If No put stuff here otherwise nil
	    nil
	    );
	 };	 // End of if statement

	 ); // End of t.schedAbs


       //Add more

     }); // End of Routine

 }; //End of Start

 )


~rp = {~start.value;};

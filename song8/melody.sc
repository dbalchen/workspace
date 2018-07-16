// =====================================================================
// SuperCollider Workspace
// =====================================================================

~tonerow = [69,64,66,68,69,64,66,64];

~tonerow =  ~pcset.value(~tonerow);
//~tonerow = [5,3,1,0];
~tonerow = ~createScale.value(~tonerow);

~verse2 = MyTrack.new(~synth1,2);
~verse2.notes.waits = ~allTimes.deepCopy;
~verse2.notes.freqs = [69,0,0,0,0,0,0,64,0,0,0,0,66,0,0,0,0,0,68,0,0,69,0,0,0,0,0,64,0,0,0,0,66,0,0,0,0,0,0,64,0,0,0,0];
~verse2.notes.durations = [2.5,0,0,0,0,0,0,1.5,0,0,0,0,2.5,0,0,0,0,0,1.5,0,0,2.5,0,0,0,0,0,1.5,0,0,0,0,2.5,0,0,0,0,0,0,1.5,0,0,0,0];
~verse2.notes.probs = ~chime.notes.probs.deepCopy;
~verse2.notes.init;

~tt = ~melCurves.value(~verse2.notes,~tonerow,2);

~tt.durations =  [0.25,0.5,0.25,0.25,0.25,0.5,0.5,0.06,0.44,0.25,0.5,0.25,0.5,0.5,0.25,0.5,0.25,0.5,1.0,0.25,0.25,0.5,0.25,0.25,0.5,0.5,0.5,0.25,0.25,0.25,0.25,0.5,0.5,0.25,0.25,0.25,0.5,0.25,0.5,0.5,0.25,0.25,0.25,0.25] * 0.9;


~verse.notes = ~tt.deepCopy;
//
~verse.notes.probs = ~chime.notes.probs.deepCopy;// * 0.66;
~verse.notes.init;
~makeWav = {
  arg wavefile;
  var f, a;
  f = SoundFile.openRead(wavefile.standardizePath);
  a = FloatArray.newClear(f.numFrames); 
  f.readData(a); 
  a = a.resamp1(4096); 
  a = a.as(Signal); 
  a = a.asWavetable; 
  Buffer.loadCollection(s, a); 
};

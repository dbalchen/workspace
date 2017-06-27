// =====================================================================
// MySampler Class
// =====================================================================


Mysampler {
  var  <>synth,<>sound,<>dur,<>fprobs,<>amp = 1,<>rate = 1,<>pattern, <>sustain = 0.5,<>out =0;

  calc {
    var lazy,freq,probs;

    lazy = Plazy({
	var flip,ary;
	probs = fprobs;
	ary = Array.newClear(fprobs.size);
	probs.do({ arg item, i;
	    flip =  rrand(0.0, 1.0);
	    if(item >= flip,{ary.put(i,1);},{ary.put(i,\rest);})
	      });
	Pseq(ary,1);
      });

    freq = Pn(lazy,inf).asStream;

    pattern = Pbind(
		    \instrument, synth,
		    \bufnum, sound,
		    \dur, Pfunc.new({dur.next}),
		    \amp,  Pfunc.new({amp}),
		    \freq,  Pfunc.new({freq.next}),
		    \rate, Pfunc.new({rate}),
		    \out, Pfunc.new({out}),
		    \sustain, Pfunc.new({sustain})
		    );
  }
}


Mykik {
  var  <>synth,<>dur,<>fprobs,<>amp = 1,<>rate = 1,<>pattern, <>sustain = 0.5,<>out =0;

  calc {
    var lazy,freq,probs;

    lazy = Plazy({
	var flip,ary;
	probs = fprobs;
	ary = Array.newClear(fprobs.size);
	probs.do({ arg item, i;
	    flip =  rrand(0.0, 1.0);
	    if(item >= flip,{ary.put(i,1);},{ary.put(i,\rest);})
	      });
	Pseq(ary,1);
      });

    freq = Pn(lazy,inf).asStream;

    pattern = Pbind(
		    \instrument, synth,
		    \dur, Pfunc.new({dur.next}),
		    \amp,  Pfunc.new({amp}),
		    \freq,  Pfunc.new({freq.next}),
		    \out, Pfunc.new({out}),
		    \sustain, Pfunc.new({sustain})
		    );
  }
}


MySynth {
  var  <>synth,<>dur,<>freqs,<>amp = 1,<>rate = 1,<>pattern, <>sustain = 0.5,<>out =0;

  calc {
    var lazy,freq,probs;

    lazy = Plazy({
	var ary;
	probs = freqs;
	ary = Array.newClear(freqs.size);
	probs.do({ arg item, i;
	    //	if(item.isKindOf(Array),{ary.put(i,item.midicps);},{ary.put(i,\rest);})
	    if(item.isKindOf(Array),{ary.put(i,item.midicps);},{if( item >= 1,{ary.put(i,item.midicps);},{ary.put(i,\rest);})})
	      });
	Pseq(ary,1);
      });

    freq = Pn(lazy,inf).asStream;

    pattern = Pbind(
		    \instrument, synth,
		    \dur, Pfunc.new({dur.next}),
		    \amp,  Pfunc.new({amp}),
		    \freq,  Pfunc.new({freq.next}),
		    \out, Pfunc.new({out}),
		    \sustain, Pfunc.new({sustain})
		    );
  }
}




MyProbs {
  var  <>freqs = nil,<>probs = nil;

  calc {
    var lazy,freq;

    lazy = Plazy({
	var ary,flip,fre;

	ary = Array.newClear(freqs.size);

	probs.do({ arg item, i;
	    flip =  rrand(0.0, 1.0);
	    if(item >= flip,{ary.put(i,1);},{ary.put(i,0);})
	      });

	fre = freqs*ary;


	fre.do({ arg item, i;
	    if(item.isKindOf(Array) && item.at(0) == 0,{fre.put(i,\rest);});
	    if(item == 0,{fre.put(i,\rest);});
	  });

	Pseq(fre,1);
      });

    freq = Pn(lazy,inf).asStream;
    ^freq;
  }
}

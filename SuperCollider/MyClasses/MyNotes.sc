// =====================================================================
// MyNotes Class
// =====================================================================


MyNotes {
	var <>freqs = nil,    <>freq = nil,
	<>probs = nil,        <>prob = nil,
	<>waits = nil,        <>wait = nil,
	<>lag = 0.0,          <>lags = nil,
	<>vel = 1,            <>vels = nil,
	<>durations = nil,    <>duration = nil,
	<>persistProbs = 1,   <>fixdurs = 0,
	<>tonerow = nil,      <>durMult = 1,
	<>scale = nil;

	init {

		if(freqs == nil,
			{freqs = [60]; });

		if(probs == nil,
			{probs = freqs.deepCopy.collect{|x| if(x == 0,{x = 0;},{x = 1;})}});

		if(waits == nil,
			{waits = Array.newClear(freqs.size).fill(1); });


		if(durations == nil,
			{
				durations = waits.deepCopy;
				this.fixDurs.value;

		});


		if(vels == nil,
			{vels = Array.newClear(freqs.size).fill(1); });

		if(lags == nil,
			{lags = Array.newClear(freqs.size).fill(0); });

		if(tonerow == nil,
			{tonerow = [0,1,2,3,4,5,6,7,8,9,10,11];});

		this.calcFreq.value;
		this.calcDur.value;
		this.calcWait.value;
		this.calcLag.value;
		this.calcVel.value;
		this.createScale.value;

	}

	calcFreq {
		var lazy;

		lazy = Plazy({

			var ary,flip,fre;

			if(freqs.size >= probs.size,{ary = Array.newClear(freqs.size);},
				{ary = Array.newClear(probs.size);});

			ary.do({ arg item, i;
				flip =  rrand(0.0, 1.0);
				if(probs.at(i%probs.size) >= flip,{ary.put(i,1);},{ary.put(i,0);})
			});

			fre = freqs*ary;

			if(fixdurs == 1,{this.fixDurs.value(ary);});

			if(persistProbs == 1, {probs = ary.deepCopy;});

			fre.do({ arg item, i;
				if(item.isKindOf(Array),{
					if(item.at(0) == 0,{fre.put(i,\rest)};)});
				if(item == 0,{fre.put(i,\rest);});
			});

			Pseq(fre,1);
		});

		freq = Pn(lazy,inf).asStream;
	}

	calcDur {

		var lazy;

		lazy = Plazy({
			Pseq(durations*durMult,1);
		});

		duration = Pn(lazy,inf).asStream;



	}

	calcWait {
		var lazy;

		lazy = Plazy({
			Pseq(waits,1);
		});

		wait =Pn(lazy,inf).asStream;

	}

	calcLag {
		var lazy;

		lazy = Plazy({
			Pseq(lags,1);
		});

		lag =Pn(lazy,inf).asStream;

	}

	calcVel {
		var lazy;

		lazy = Plazy({
			Pseq(vels,1);
		});

		vel =Pn(lazy,inf).asStream;

	}

	fixDurs {arg proby = probs;

		proby.do({arg item, i;

			var dur = 0, count = i+1;

			if ((item != 0),{
				dur = waits[i];
				while({(proby[count] == 0) && (count < proby.size)},{
					dur = dur + waits[count];
					count = count + 1;
				});

				durations[i] = dur;
			},
			{
				durations[i] = 0;
			}

		)});

		durations.postln;
	}

	createScale {

		for(0,12,
			{ arg i;
				tonerow.do({arg item, ii;

					var point;

					point = item + (i*12);

					if((point >=0) && (point <= 120),{

						scale = scale.add(point);

				};)});
		});
		scale = scale.sort;
	}

}






MyFilter {

  var <>in, <>out,<>name = "filter",
    <>attacks = nil,   <>attack = 0.5,
    <>releases = nil,  <>release = 0.5,
    <>att = 1.0, <>rel = 1.0, 
    <>cutoff = 5000.00, <>gain = 2.0,
    <>sustain = 1.0, <>aoc = 1.0, 
    <>flter = nil,  <>doneAction = 2;

  setFilter
    {arg filt;

      filt.set(\cutoff,cutoff);
      filt.set(\gain,gain);
      filt.set(\aoc,aoc);
      filt.set(\fattack,att.next * attack);
      filt.set(\fsustain,sustain);
      filt.set(\frelease,rel.next * release);
    }
  init {

    if(attacks == nil,
      {attacks = [1.0,1.0,1.0,1.0];});
    if(releases == nil,
      {releases = [1.0,1.0,1.0,1.0];});

    this.calcAttack.value;
    this.calcRelease.value;
  }


  calcAttack {
    var lazy;

    lazy = Plazy({
	Pseq(attacks*attack,1);
      });

    att = Pn(lazy,inf).asStream;
  }

  calcRelease {
    var lazy;

    lazy = Plazy({
	Pseq(releases*release,1);
      });

    rel = Pn(lazy,inf).asStream;
  }

  makeGui
    {
      var fltWin, nb1, sl1, nb2, sl2, nb3, sl3, nb4, sl4, nb5, sl5, nb6, sl6;

      fltWin = Window.new(name,Rect(200,200,372,295)).front;
      StaticText( fltWin, Rect(4, 4, 50, 25 )).align_( \left ).string_( "Cut:" );

      nb1 = NumberBox(fltWin, Rect(240, 4, 53, 25)).value_(cutoff);
      sl1 = Slider(fltWin, Rect(35, 9, 200, 15))
	.value_(nb1.value/10000)
	.action_({
	    nb1.value_(sl1.value * 10000);
	    cutoff = nb1.value;
	  });

      nb1.action_({
	  sl1.value_(nb1.value/10000);
	  cutoff = sl1.value;
	});

      StaticText( fltWin, Rect(4, 30, 50, 25 )).align_( \left ).string_( "Res:" );
      nb2 = NumberBox(fltWin, Rect(240, 30, 53, 25)).value_(gain);

      sl2 = Slider(fltWin, Rect(35, 35, 200, 15))
	.value_(nb2.value/4)
	.action_({
	    nb2.value_(sl2.value * 4);
	    gain = nb2.value;
	  });

      nb2.action_({
	   
	  sl2.value_(nb2.value/4);
	  gain = sl2.value;
	});

      StaticText( fltWin, Rect(4, 56, 50, 25 )).align_( \left ).string_( "Aoc:" );
      nb3 = NumberBox(fltWin, Rect(240, 56, 53, 25)).value_(aoc);

      sl3 = Slider(fltWin, Rect(35, 61, 200, 15))     
	.value_(nb3.value/10)
	.action_({
	    nb3.value_(sl3.value * 10);
	    aoc = nb3.value/10;
	  });

      nb3.action_({
	  sl3.value_(nb3.value/10);
	  aoc = nb3.value/10;
	});

      StaticText( fltWin, Rect(4, 90, 50, 25 )).align_( \left ).string_( "Atk:" );
      nb4 = NumberBox(fltWin, Rect(240, 90, 53, 25)).value_(attack);

      sl4 = Slider(fltWin, Rect(35, 95, 200, 15))
	.value_(nb4.value/10)
	.action_({
	    nb4.value_(sl4.value * 10);
	    attack = nb4.value;
	  });

      nb4.action_({
	  sl4.value_(nb4.value/10);
	  attack = nb4.value;
	});


      StaticText( fltWin, Rect(4, 116, 50, 25 )).align_( \left ).string_( "Rel:" );
      nb5 = NumberBox(fltWin, Rect(240, 116, 53, 25)).value_(release);

      sl5 = Slider(fltWin, Rect(35, 121, 200, 15))
	.value_(nb5.value/10)
	.action_({
	    nb5.value_(sl5.value * 10);
	    release = nb5.value;
	  });

      nb5.action_({
	  sl5.value_(nb5.value/10);
	  release = nb5.value;
	});


      StaticText( fltWin, Rect(4, 142, 50, 25 )).align_( \left ).string_( "Sus:" );
      nb6 = NumberBox(fltWin, Rect(240, 142, 53, 25)).value_(sustain);

      sl6 = Slider(fltWin, Rect(35, 147, 200, 15))
	.value_(nb6.value)
	.action_({
	    nb6.value_(sl6.value);
	    sustain = nb6.value;
	  });

      nb6.action_({
	  sl6.value_(nb6.value);
	  sustain = nb6.value;
	});

    }

}


MyADSR {

	var <>name = "My ADSR",
	<>attack = 0.5,<>release = 0.5,
	<>decay = 0.0, <>sustain = 1.0;


	init {

		this.attack = 0.5;
		this.decay = 0.0;
		this.sustain = 1.0;
		this.release = 0.0;
	}

	gui {

		var envWin, nb1, sl1, nb2, sl2, nb3, sl3, nb4, sl4, nb5, sl5, nb6, sl6;

		envWin = Window.new(name,Rect(200,200,305,155)).front;
		StaticText( envWin, Rect(4, 4, 50, 25 )).align_( \left ).string_( "Atk:" );

		nb1 = NumberBox(envWin, Rect(240, 4, 53, 25)).value_(attack);
		sl1 = Slider(envWin, Rect(35, 9, 200, 15))
		.value_(nb1.value/10)
		.action_({
			nb1.value_(sl1.value * 10);
			attack = nb1.value;
		});

		nb1.action_({
			sl1.value_(nb1.value/10);
			attack = sl1.value;
		});


		StaticText( envWin, Rect(4, 32, 50, 25 )).align_( \left ).string_( "Dcy:" );
		nb2 = NumberBox(envWin, Rect(240, 30, 53, 25)).value_(decay);

		sl2 = Slider(envWin, Rect(35, 37, 200, 15))
		.value_(nb2.value/10)
		.action_({
			nb2.value_(sl2.value * 10);
			decay = nb2.value;
		});

		nb2.action_({

			sl2.value_(nb2.value/10);
			decay = sl2.value;
		});


		StaticText( envWin, Rect(4, 58, 50, 25 )).align_( \left ).string_( "Sus:" );
		nb3 = NumberBox(envWin, Rect(240, 58, 53, 25)).value_(sustain);

		sl3 = Slider(envWin, Rect(35, 63, 200, 15))
		.value_(1)
		.action_({
			nb3.value_(sl3.value);
			sustain = nb3.value;
		});

		nb3.action_({
			sl3.value_(nb3.value);
			sustain = nb3.value;
		});

		StaticText( envWin, Rect(4, 84, 50, 25 )).align_( \left ).string_( "Rel:" );
		nb4 = NumberBox(envWin, Rect(240, 84, 53, 25)).value_(release);

		sl4 = Slider(envWin, Rect(35, 89, 200, 15))
		.value_(nb4.value/10)
		.action_({
			nb4.value_(sl4.value * 10);
			release = nb4.value;
		});

		nb4.action_({
			sl4.value_(nb4.value/10);
			release = nb4.value;
		});

	}

	setADSR
	{
		arg env;
		env.set(\attack,attack);
		env.set(\decay,decay);
		env.set(\sustain,sustain);
		env.set(\release,release);
	}
}
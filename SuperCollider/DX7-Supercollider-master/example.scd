// Supercollider DX7 Clone v1.0
// Implemented by Aziz Ege Gonul for more info go to www.egegonul.com
// Under GNU GPL 3 as per SuperCollider license

//Example

( // init
	// Server.killAll
	s.boot;
    ~mainCaller = ("./DX7.scd").loadRelative.wrapAt(-1);
)

( // Note On 80 message with velocity value 100 and preset value 10000
    ~mainCaller.value(50, 127, 1198);
)

( // Note Off message
	~mainCaller.value(50, 0);
)
/*
//Some fun example below. Uncomment this area and run the below parenthesis for random preset and pitch for each note. Check CPU!!
(
~number = 15000.rand; //preset start number, dont go further than 16383
~ra = Routine {
303.do({ arg a;
~sun = 99.rand + 10;
~mainCaller.value(~sun, 127.rand, ~number);
((50.rand)/100).wait; // Waits for at most half second between each node
~mainCaller.value(~sun, 0, ~number);
~number = ~number +1;
});
// Wait half second before saying we're done
0.5.wait;
"done".postln;
}.play;
)
(//stop
~ra.stop;
~mainCaller.value(~sun, 0, ~number);
)

*/


Array.rand(7, 50, ).postln;



(
var p, l, rando;
p = Pipe.new("cat /home/dbalchen/Music/SuperCollider/include/Synths/DX7-Supercollider-master/pianos.txt | cut -d' ' -f1 | sort -n -u ", "r");            // list directory contents in long format
l = p.getLine;                    // get the first line
while({l.notNil}, {l.postln;



	20.do{

		rando = rrand(50,60);
		rando.postln;
         ~mainCaller.value(rando, 127, l);
			1.25.wait;
	~mainCaller.value(rando, 0);
			};

	l = p.getLine;
});    // post until l = nil
p.close;                    // close the pipe to avoid that nasty buildup
)






(

{
    var rando;

	20.do{

		rando = rrand(50,60);
		rando.postln;
         ~mainCaller.value(rando, 127, 15);
			1.25.wait;
	~mainCaller.value(rando, 0);
			};


}.fork;

)
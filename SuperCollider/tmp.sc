// =====================================================================
// SuperCollider Workspace
// =====================================================================

~testString = "UNKNOWN:0:2.5,1.00:[1,2,3],35,[35,42],[43,66,80,22],35:1,1,1:2.0,1.0,1.0";

~alist = ~testString.split($:).as(Array);

~name = ~alist[0];
~channel = ~alist[1].asInteger;

~waits = ~alist[2].split($,).asFloat.as(Array);

~freqs = (~alist[3].split($[));

~stuff = Array.new(128);

~freqs[0];
x = (~freqs[0].separate);
x = x.drop(-1);

x = x.join;
~tmp

	  if(~freqs[0].contains('\]'),
	    { "Hello".postln;},
		  {~tmp = ~freqs[0].drop(-1).split($,).asInteger; ~tmp.collect{|x| ~stuff.add(x.asInteger) } });

~stuff

~freqs[0].drop(-1).split($,).asInteger.flat;

(
 ~removeCommas = {arg rawstring;
   var converted, splitA;

   splitA = rawstring.separate;

   if(splitA.first == ",",
     {splitA = splitA.drop(1);});
   if(splitA.last == ",",
     {splitA = splitA.drop(-1);});

   converted = splitA.join;

   converted;};


 ~convertS2A = {arg rawstring;

		var converted = Array.new(1280), tmp, splitA, x;
		splitA = rawstring.split($[).as(Array); 

		for (0, splitA.size-1,
	    { arg i; 
    		x = splitA[i].asString;

			if(x.contains("]"),
			  { 

		    tmp = x.split($]).as(Array); 
			  tmp[0] = ~removeCommas.value(tmp[0]);
				  tmp[0] = tmp[0].split($,).asInteger;
				  converted.add(tmp[0]);
				  tmp[1] = ~removeCommas.value(tmp[1]);

				  if(tmp[1].size != 0,
				    { 
				      tmp[1] = tmp[1].split($,).asInteger; 
				      tmp[1].collect{|y| converted.add(y.asInteger) }
				    });
				  },
				  {
				    x = ~removeCommas.value(x);
				    if(x.size != 0,
				      { 
					tmp = x.split($,).asInteger; tmp.collect{|y| converted.add(y.asInteger) } 
				      });
				  });
				 });
   converted; 
 };

)
~alist[3]

x = ~convertS2A.value(~alist[3]);
x[0];
x = ~removeCommas.value(~freqs[0]);


for (0, 7, { arg i; i.postln }); 

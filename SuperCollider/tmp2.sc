(
 ~removeCommas =  {arg rawstring;
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
~buildDic =
{arg pcset1, pcset2;
	var ldic;

	ldic = Dictionary.new;

	pcset1.do({ arg item, i;

		ldic.put(item,pcset2[i]);

	});
	ldic;
};

~useDic =
{arg num, dic,key;

	var base, prime;

	prime = num%12;

	prime = prime - key;

	base = (num / 12).asInteger;

	if (prime < 0;,{prime = prime + 12;base = base -1});

	prime = dic.at(prime) + key + (12*base);

	prime;

};


~fullDic = {arg notes, dic, key;

	var notesback = Array.new(notes.size);

	notes.do({arg item, i;

		notesback.insert(i,~useDic.value(item,dic,key));

	});

	notesback;
};
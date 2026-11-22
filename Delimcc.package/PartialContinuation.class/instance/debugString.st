debugging
debugString
	"A debugging aid: the source of the method of each of my contexts, top first, each followed by a line of =."

	^ String streamContents: [ :s |
		  self stack do: [ :each |
			  s
				  nextPutAll: each method sourceCode;
				  cr;
				  nextPutAll: '=======';
				  cr ] ]
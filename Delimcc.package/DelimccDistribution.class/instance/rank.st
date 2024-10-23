accessing
rank

	| rank c |
	c := count asFloat.
	rank := distribution associations collect: [ :each |
		        each key -> (each value / c) ].

	^ rank timsort: #value reverse: true
adding - dispatched
addObject: anObject occurrences: o

	| v |
	v := distribution at: anObject ifAbsentPut: 0.
	distribution at: anObject put: v + o.

	count := count + o
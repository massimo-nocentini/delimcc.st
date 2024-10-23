adding
addObject: anObject occurrences: o

	anObject ifNotNil: [
		| v |
		v := distribution at: anObject ifAbsentPut: 0.
		distribution at: anObject put: v + o.

		count := count + o ]
helpers
safe: column row: row placed: placed

	placed doWithIndex: [ :each :r |
		(each = column or: [ (each - column) abs = (row - r) ]) ifTrue: [ ^ false ] ].
	^ true
accessing
rank

	^ distribution associations
		  collect: [ :each | each key -> (each value / count) asFloat ];
		  timsort: #value reverse: true
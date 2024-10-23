accessing
values

	^ Array new: count streamContents: [ :aStream |
		  distribution keysAndValuesDo: [ :value :occurrences |
			  occurrences timesRepeat: [ aStream << value ] ] ]
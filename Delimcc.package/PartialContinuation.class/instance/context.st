accessing
context

	^ context ifNil: [ context := from copyTo: to ]
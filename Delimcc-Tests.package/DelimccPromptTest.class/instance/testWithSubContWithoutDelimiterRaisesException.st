tests - basics
testWithSubContWithoutDelimiterRaisesException
	"Nothing is cut when the delimiter is missing, so the computation goes on after the error is handled."

	| error |
	error := [ q delimit: [ p withSubCont: [ :k | 1 ] ] ]
		         on: MissingResetException
		         do: [ :e | e ].
	self assert: error prompt identicalTo: p.
	self assert: error messageText equals: 'no delimiter of a DelimccPrompt(p) on the stack'.
	self assert: 1 + ([ p withSubCont: [ :k | 1 ] ] on: MissingResetException do: [ :e | e return: 7 ]) equals: 8.
	"withSubCont: removes the delimiter, so a second capture inside its block finds none."
	self should: [ p delimit: [ p withSubCont: [ :k | p withSubCont: [ :k2 | 0 ] ] ] ] raise: MissingResetException
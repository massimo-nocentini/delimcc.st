helpers - debugger
is: aContext aboutToSend: aSelector
	"Answer whether the next step of aContext sends aSelector, as the debugger shows it."

	| node |
	node := aContext method sourceNodeForPC: aContext pc.
	^ node isMessage and: [ node selector == aSelector ]
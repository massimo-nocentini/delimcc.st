initialization
setFrames: someContexts
	"Copy someContexts from the bottom up, chaining the copies, and the objects of each one that the first invocation may change (#freezeObjectsOf:)."

	| below |
	frames := someContexts.
	copies := Array new: someContexts size.
	below := nil.
	someContexts size to: 1 by: -1 do: [ :i |
		below := copies at: i put: ((someContexts at: i) shallowCopy
				          privSender: below;
				          yourself).
		self freezeObjectsOf: below ]
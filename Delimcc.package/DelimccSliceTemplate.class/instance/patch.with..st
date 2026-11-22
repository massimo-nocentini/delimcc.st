private
patch: someContexts with: someObjects
	"Apply my patches to someContexts and someObjects, copies of my contexts and objects."

	1 to: patches size by: 3 do: [ :i |
		| holder field target |
		holder := patches at: i.
		field := patches at: i + 1.
		target := patches at: i + 2.
		target := target > 0
			          ifTrue: [ someContexts at: target ]
			          ifFalse: [ someObjects at: 0 - target ].
		holder > 0
			ifTrue: [
				field > 0
					ifTrue: [ (someContexts at: holder) instVarAt: field put: target ]
					ifFalse: [ (someContexts at: holder) at: 0 - field put: target ] ]
			ifFalse: [
				field > 0
					ifTrue: [ (someObjects at: 0 - holder) instVarAt: field put: target ]
					ifFalse: [ (someObjects at: 0 - holder) basicAt: 0 - field put: target ] ] ]
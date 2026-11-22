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
			          ifFalse: [ someObjects at: target negated ].
		holder > 0
			ifTrue: [
				field > 0
					ifTrue: [ (someContexts at: holder) instVarAt: field put: target ]
					ifFalse: [ (someContexts at: holder) at: field negated put: target ] ]
			ifFalse: [
				field > 0
					ifTrue: [ (someObjects at: holder negated) instVarAt: field put: target ]
					ifFalse: [ (someObjects at: holder negated) basicAt: field negated put: target ] ] ]
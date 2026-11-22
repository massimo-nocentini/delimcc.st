*Delimcc
isSteppingGuardDelimcc
	"Answer whether I am one of the contexts that the debugger inserts below a context to run it until it returns (Context class>>#contextEnsure: and #contextOn:do:, which #runUntilErrorOrReturnFrom: and #runUntilReturnFrom: insert): an #ensure: or #on:do: context whose receiver was made by one of them. The primitive is tested first: only the methods of BlockClosure and Context carry these marks, so the receiver, which may be a ProtoObject otherwise, understands #isClosure."

	| primitive home |
	primitive := method primitive.
	(primitive = 198 or: [ primitive = 199 ]) ifFalse: [ ^ false ].
	receiver isClosure ifFalse: [ ^ false ].
	home := receiver method method.
	^ home methodClass == Context class and: [ home selector == #contextEnsure: or: [ home selector == #contextOn:do: ] ]
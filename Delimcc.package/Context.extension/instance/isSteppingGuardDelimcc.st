*Delimcc
isSteppingGuardDelimcc
	"Answer whether I am one of the contexts that the debugger inserts below a context to run it until it returns (Context class>>#contextEnsure: and #contextOn:do:, which #runUntilErrorOrReturnFrom: and #runUntilReturnFrom: insert): an #ensure: or #on:do: context whose receiver was made by one of them. The receiver is tested first, as most are not closures."

	| primitive home |
	receiver isClosure ifFalse: [ ^ false ].
	primitive := method primitive.
	(primitive = 198 or: [ primitive = 199 ]) ifFalse: [ ^ false ].
	home := receiver method method.
	^ home methodClass == Context class and: [ home selector == #contextEnsure: or: [ home selector == #contextOn:do: ] ]
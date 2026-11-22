*Delimcc-Continuation-private
restoreValues
	"Give each context that I saved the state that it had when I was captured, from the top one to the bottom one. A continuation in the stock layout (see #hasSnapshots) is restored as the stock method did."

	self hasSnapshots ifFalse: [ ^ self restoreSlotValues ].
	1 to: values size by: 2 do: [ :index |
		self restore: (values at: index) from: (values at: index + 1) ]
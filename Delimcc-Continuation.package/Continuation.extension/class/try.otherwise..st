*Delimcc-Continuation-instance creation
try: tryBlock otherwise: elseBlock
	"Answer what tryBlock answers, unless it invokes the continuation that it gets as argument: then answer what elseBlock answers to the object that tryBlock invoked it with.
	Both blocks are culled, as #try:or:otherwise: and #try:or:or:otherwise: cull theirs, so either one can take no argument."

	^ self currentDo: [ :success |
		  | localResult |
		  localResult := self currentDo: [ :local |
			                 success value: (tryBlock cull: local) ].
		  elseBlock cull: localResult ]
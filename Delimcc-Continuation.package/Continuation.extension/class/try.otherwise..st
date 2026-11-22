*Delimcc-Continuation-instance creation
try: tryBlock otherwise: elseBlock
	"Answer what tryBlock answers, unless it invokes the continuation that it gets as argument: then answer what elseBlock answers to the object that tryBlock invoked it with.
	Both blocks are culled, so either one can take no argument. #try:or:otherwise: and #try:or:or:otherwise: pass their try block to this method, so their try block can take no argument too (stock sent it value: in all three)."

	^ self currentDo: [ :success |
		  | localResult |
		  localResult := self currentDo: [ :local |
			                 success value: (tryBlock cull: local) ].
		  elseBlock cull: localResult ]
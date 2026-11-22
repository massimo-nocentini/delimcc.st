scanning
scan: aCompiledCode
	"Answer the indices of the temporaries into which aCompiledCode stores an Array right after it has created it with pushNewArray."

	| stream slots |
	slots := OrderedCollection new.
	stream := InstructionStream on: aCompiledCode.
	[ stream atEnd ] whileFalse: [
		| created |
		created := state == #newArray.
		state := nil.
		stream interpretNextInstructionFor: self.
		(created and: [ state isInteger ]) ifTrue: [ slots addIfNotPresent: state ] ].
	^ slots asArray
accessing
vectorSlotsOf: aCompiledCode
	"Answer the indices of the temporaries in which aCompiledCode keeps the temp vectors that it creates. The answers are cached in Entries, a table of 4096 entries indexed by the basic identity hash, whose low bits differ from code to code, unlike those of #identityHash, which are 0; each entry a code and its answer: a miss replaces one entry with a single store, so a process that reads the table meanwhile finds the old entry or the new one, and the cost of a miss does not grow with the number of codes met."

	| index entry slots |
	index := (aCompiledCode basicIdentityHash bitAnd: 4095) + 1.
	entry := (Entries ifNil: [ Entries := Array new: 4096 ]) at: index.
	(entry notNil and: [ entry key == aCompiledCode ]) ifTrue: [ ^ entry value ].
	slots := self new scan: aCompiledCode.
	Entries at: index put: aCompiledCode -> slots.
	^ slots
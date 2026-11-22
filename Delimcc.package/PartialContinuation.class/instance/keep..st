private
keep: aTemplate
	"Keep aTemplate as mine and answer true, or answer false when I have one already. Taking my contexts in #framesForShot involves no send, so a process that runs natively takes them alone, but a debugger that steps it runs Smalltalk between its bytecodes: another invocation can then take my contexts too, and the one that keeps its template second must not run or unwind them again."

	template ifNotNil: [ ^ false ].
	template := aTemplate.
	^ true
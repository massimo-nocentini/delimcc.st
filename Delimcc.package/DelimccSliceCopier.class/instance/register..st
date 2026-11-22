copying
register: anObject
	"Copy anObject into the template and answer the code of the copy."

	| code |
	objects ifNil: [
		objects := OrderedCollection new.
		codes := IdentityDictionary new ].
	objects add: anObject shallowCopy.
	code := objects size negated.
	codes at: anObject put: code.
	^ code
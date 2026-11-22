*Delimcc-Continuation-Tests-functions
linkedListFrom: aValueLink
	"Answer a new LinkedList of the values of the chain of ValueLinks that starts at aValueLink, empty when aValueLink is nil.
	LinkedList with: aValueLink would answer a list whose first link is also its last one, or a list of nil."

	| list link |
	list := LinkedList new.
	link := aValueLink.
	[ link isNil ] whileFalse: [
		list add: (ValueLink value: link value).
		link := link nextLink ].
	^ list
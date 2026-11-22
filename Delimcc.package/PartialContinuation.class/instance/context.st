accessing
context
	"Answer a copy of my contexts, the top one first, or nil when I have none."

	^ from ifNotNil: [ from copyTo: to ]
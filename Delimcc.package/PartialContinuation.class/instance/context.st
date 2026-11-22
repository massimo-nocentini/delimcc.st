accessing
context
	"Answer a copy of my contexts, the top one first, or nil when I have none. Once I have been invoked, it is a copy of my template, so it shares no context with an invocation."

	template ifNotNil: [ ^ template instantiate ifEmpty: [ nil ] ifNotEmpty: [ :frames | frames first ] ].
	^ from ifNotNil: [ from copyTo: nil ]
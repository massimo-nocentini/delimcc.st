private
awaitTemplate
	"Another process has taken my contexts for my first invocation and is making my template: wait for it, whatever the priorities are."

	[ template isNil ] whileTrue: [ (Delay forMilliseconds: 1) wait ].
	^ template
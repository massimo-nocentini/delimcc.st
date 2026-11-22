private
awaitTemplate
	"Another process has taken my contexts for my first invocation and is making my template: wait for it, whatever the priorities are, or for my contexts, which that process gives back when it fails."

	[ template isNil and: [ from isNil ] ] whileTrue: [ (Delay forMilliseconds: 1) wait ]
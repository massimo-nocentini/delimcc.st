tests - snapshots
testEscapeAndReentryInADeepStack
	"An escape from 3000 frames deeper than the capture, whose frames are still married to stack pages, and re-entries into a stack of 3000 frames that has returned, as a generator does."

	| r |
	log := OrderedCollection new.
	r := Continuation currentDo: [ :c |
		     k := c.
		     self depth: 3000 do: [ [ k value: #escaped ] ensure: [ log add: #ensure ] ] ].
	self assert: r equals: #escaped.
	self assert: log asArray equals: #( #ensure ).
	log := OrderedCollection new.
	shots := 0.
	r := self captureBelow: 3000.
	shots := shots + 1.
	shots < 3 ifTrue: [ k value: shots * 10 ].
	self assert: shots equals: 3.
	self assert: r equals: 20.
	self assert: log size equals: 2.
	self assert: log first equals: log last
tests - ensure
testIfCurtailedOfAnUnwoundShot
	"The second invocation is unwound by the ZeroDivide that it raises; the first one completes."

	self
		assert: {
				[
				[
				| v |
				v := [ :k | (k value: 1) + ([ k value: 2 ] on: ZeroDivide do: [ :e | 100 ]) ] shift.
				v = 2 ifTrue: [ 1 / 0 ].
				v ] ifCurtailed: [ log add: #curtailed ] ] reset.
				log asArray }
		equals: #( 101 #( #curtailed ) )
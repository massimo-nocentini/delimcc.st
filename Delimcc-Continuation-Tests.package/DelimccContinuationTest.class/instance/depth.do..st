helpers
depth: n do: aBlock
	"Answer what aBlock answers, evaluated n frames deeper. Each frame changes a temporary after aBlock has answered, so a re-entry shows whether the frame got back the temporary it had when it was captured."

	| t r |
	t := n.
	n = 0 ifTrue: [ ^ aBlock value ].
	r := self depth: n - 1 do: aBlock.
	t := t + 1000.
	^ r
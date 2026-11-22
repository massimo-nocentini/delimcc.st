tests - structure
testAProxyReceiverInTheSlice
	"A context of the slice runs a method of a ProtoObject, which understands neither isClosure nor isContext: k still runs, twice, unwinds, and re-enters callcc (review-semantics 1)."

	| proxy k n |
	proxy := DelimccTestProxy new.
	self
		assert: (self isolated: [ [ proxy value: [ [ :kk | (kk value: 1) + (kk value: 2) ] shift ] ] reset ])
		equals: 3.
	k := [ [ proxy value: [ [ :kk | kk ] shift ] ] ensure: [ log add: #closed ] ] reset.
	self assert: (self isolated: [ k unwind. log asArray ]) equals: #( #closed ).
	n := 0.
	self
		assert: (self isolated: [
				 [
				 | kc m |
				 m := proxy value: [ [ :kk | kc := kk. 0 ] callcc ].
				 n := n + 1.
				 n < 3 ifTrue: [ kc value: m + 1 ].
				 m ] reset ])
		equals: 2
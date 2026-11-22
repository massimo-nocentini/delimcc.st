tests - structure
testAProxySignalerInTheSlice
	"An exception of the slice refers to a ProtoObject, its signaler or the receiver of a message that it does not understand: k still runs twice (review-semantics 1)."

	| proxy |
	proxy := DelimccTestProxy new.
	self
		assert: (self isolated: [
				 [ [ Error new signaler: proxy; signal ] on: Error do: [ :e | [ :kk | (kk value: 1) + (kk value: 2) ] shift ] ] reset ])
		equals: 3.
	self
		assert: (self isolated: [
				 [ [ proxy zork ] on: MessageNotUnderstood do: [ :e | [ :kk | (kk value: 10) + (kk value: 20) ] shift ] ] reset ])
		equals: 30
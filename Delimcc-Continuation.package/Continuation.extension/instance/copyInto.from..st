*Delimcc-Continuation-private
copyInto: aContext from: aSnapshot
	"Copy every slot of aSnapshot into aContext.
	The primitive is the one of Object>>#copyFrom:, used as a mirror primitive: aContext is its receiver and aSnapshot its argument, so it needs no method on Context. It copies the instance variables and all the stack slots at once. It fails when aContext is still married to a frame (#restore:from: stores the pc first so that it is not). Then, or if it fails for any other reason, I store the slots one by one, as the stock #restoreValues did: the instance variables with #instVarAt:put:, then the stack slots up to stackp with #at:put:."

	<primitive: 168 error: errorCode>
	1 to: aContext class instSize do: [ :index |
		aContext instVarAt: index put: (aSnapshot instVarAt: index) ].
	1 to: aSnapshot size do: [ :index |
		aContext at: index put: (aSnapshot at: index) ]
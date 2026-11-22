*Delimcc-Continuation-private
restore: aContext from: aSnapshot
	"Give aContext the state that aSnapshot saved.
	Storing the pc (instance variable 2) first makes aContext a plain heap context if it was still married to a frame, as are the frames that the current stack shares with the captured one: the VM then moves the frame into aContext. #copyInto:from: copies the rest with one primitive, which fails for a married context. The stock #restoreValues stored the sender first, then the pc and every other slot, so each married frame ended up as a heap context there too. Going from the top context to the bottom one, as #restoreValues does, each married frame is the top frame of its stack page when it is moved, which is the cheap case. Letting the primitive fail instead would be slow: on a failure the VM follows forwarders in the receiver of the primitive, here me, so it scans all of values each time."

	aContext instVarAt: 2 put: (aSnapshot instVarAt: 2).
	self copyInto: aContext from: aSnapshot
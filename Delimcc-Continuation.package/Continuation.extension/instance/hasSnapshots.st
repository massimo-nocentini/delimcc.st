*Delimcc-Continuation-private
hasSnapshots
	"Answer whether values has the layout that #initializeFromContext: writes now, (context1 snapshot1 context2 snapshot2 ...), and not the one of the stock method, (context1 sender pc stackp method closureOrNil receiver slot1 ... slotN context2 ...), which a continuation captured before Delimcc-Continuation was loaded still has.
	In the stock layout the third element is the pc of the first context, an integer or nil; in the new one it is the second context, or there is no third element."

	^ values size < 3 or: [ (values at: 3) isContext ]
helpers
mismatchesOfSnapshotsOf: aContext
	"Capture aContext, a suspended sender of mine, both with Continuation>>#fromContext: and as the stock method did, and answer the number of frames and what differs between the snapshots and the stock values."

	| captured stock mismatches stockIndex context snapshot frames |
	captured := (Continuation fromContext: aContext) instVarNamed: #values.
	stock := self stockValuesOf: aContext.
	mismatches := OrderedCollection new.
	stockIndex := 1.
	frames := 0.
	1 to: captured size by: 2 do: [ :index |
		context := captured at: index.
		snapshot := captured at: index + 1.
		frames := frames + 1.
		(stock at: stockIndex) == context ifFalse: [
			mismatches add: { frames. #context } ].
		snapshot == context ifTrue: [ mismatches add: { frames. #notACopy } ].
		snapshot class == Context ifFalse: [
			mismatches add: { frames. #class } ].
		1 to: Context instSize do: [ :i |
			(snapshot instVarAt: i) == (stock at: stockIndex + i) ifFalse: [
				mismatches add: { frames. Context allInstVarNames at: i } ] ].
		snapshot size = (stock at: stockIndex + 3) ifFalse: [
			mismatches add: { frames. #size } ].
		1 to: snapshot size do: [ :i |
			(snapshot at: i) == (stock at: stockIndex + Context instSize + i)
				ifFalse: [ mismatches add: { frames. #slot. i } ] ].
		stockIndex := stockIndex + 1 + Context instSize + snapshot size ].
	stockIndex = (stock size + 1) ifFalse: [ mismatches add: #length ].
	^ { frames. mismatches asArray }
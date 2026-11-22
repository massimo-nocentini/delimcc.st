helpers
stockContinuationFrom: aContext
	"Answer a continuation of aContext in the stock layout of values, as one captured before Delimcc-Continuation was loaded."

	^ Continuation basicNew
		  instVarNamed: #values put: (self stockValuesOf: aContext);
		  yourself
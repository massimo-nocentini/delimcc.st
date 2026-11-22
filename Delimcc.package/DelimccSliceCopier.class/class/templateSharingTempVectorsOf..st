instance creation
templateSharingTempVectorsOf: anArray
	"Answer a DelimccSliceTemplate of the contexts of anArray, as #templateOf: does, but whose copies share the temp vectors of these contexts instead of copying them (no R5)."

	^ self new
		  sharesTempVectors: true;
		  templateOf: anArray
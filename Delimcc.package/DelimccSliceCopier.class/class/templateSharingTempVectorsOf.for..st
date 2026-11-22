instance creation
templateSharingTempVectorsOf: someCopies for: someContexts
	"Answer the DelimccSliceTemplate whose contexts are someCopies, made by #copiesOf: from someContexts, which may have run since, and whose copies share their temp vectors (no R5)."

	^ self new
		  sharesTempVectors: true;
		  templateOf: someCopies for: someContexts
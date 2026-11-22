private
isShared: anObject

	^ anObject == lastShared or: [ shared notNil and: [ shared includes: anObject ] ]
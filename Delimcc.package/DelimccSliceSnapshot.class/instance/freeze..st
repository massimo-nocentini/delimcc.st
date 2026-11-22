private
freeze: anObject
	"Keep a shallow copy of anObject, which the first invocation may change, for the copier to read instead."

	(snapshots ifNil: [ snapshots := OrderedCollection new ])
		add: anObject;
		add: anObject shallowCopy
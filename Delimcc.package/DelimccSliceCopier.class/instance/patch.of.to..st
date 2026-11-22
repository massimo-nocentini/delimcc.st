copying
patch: aField of: aHolderCode to: aCode

	(patches ifNil: [ patches := OrderedCollection new ])
		add: aHolderCode;
		add: aField;
		add: aCode
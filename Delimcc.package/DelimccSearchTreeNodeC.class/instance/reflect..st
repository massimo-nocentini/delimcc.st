tests - utilities
reflect: cont

	^ self class new
		  slot: [ self slot value reflect: cont ];
		  yourself
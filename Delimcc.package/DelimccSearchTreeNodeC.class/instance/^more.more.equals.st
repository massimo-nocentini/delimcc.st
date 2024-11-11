monad
>>= aBlock

	^ self class new
		  slot: [ self slot value >>= aBlock ];
		  yourself
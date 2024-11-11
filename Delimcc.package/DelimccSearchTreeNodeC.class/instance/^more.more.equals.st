monad
>>= aBlock

	^ self class suspended: [ self slot value >>= aBlock ]
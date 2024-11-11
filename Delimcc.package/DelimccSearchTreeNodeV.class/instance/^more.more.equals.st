monad
>>= aBlock

	^ self class suspended: [ aBlock value: self slot ]
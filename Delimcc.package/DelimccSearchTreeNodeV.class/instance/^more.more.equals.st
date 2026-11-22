monad
>>= aBlock

	^ self class suspended: [
		  aBlock cull: self slot cull: DelimccSearchTree new ]
accessing
vectorSlotsOf: aCompiledCode
	"Answer the indices of the temporaries in which aCompiledCode keeps the temp vectors that it creates. A miss installs a new cache, a copy of the old one, rather than changing the cache that another process may be reading."

	| cache |
	cache := Cache ifNil: [ WeakIdentityKeyDictionary new ].
	^ cache at: aCompiledCode ifAbsent: [
		  | slots |
		  slots := self new scan: aCompiledCode.
		  Cache := cache copy
			           at: aCompiledCode put: slots;
			           yourself.
		  slots ]
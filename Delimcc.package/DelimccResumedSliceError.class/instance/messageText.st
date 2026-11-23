accessing
messageText

	^ messageText ifNil: [ 'the contexts of this continuation were resumed after its capture and before its first invocation, as by a Continuation captured inside its delimiter' ]
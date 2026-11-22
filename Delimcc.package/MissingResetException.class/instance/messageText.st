accessing
messageText

	^ messageText ifNil: [ 'no delimiter of ' , prompt printString , ' on the stack' ]
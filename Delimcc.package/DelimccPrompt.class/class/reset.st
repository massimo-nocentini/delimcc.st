accessing
reset
	"Answer the prompt that BlockClosure>>#reset and #shift use."

	^ Reset ifNil: [ Reset := self new ]
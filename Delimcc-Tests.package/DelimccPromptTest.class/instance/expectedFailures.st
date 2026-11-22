failures
expectedFailures
	"These need the copies of a slice to re-point its closures and its exceptions to the copies (WP2 of proto-multiprompt): they fail on plain copies."

	^ #( #testNonLocalReturnFromKInDetect #testNonLocalReturnFromKInAnySatisfy #testShiftInsideAHandlerResumesItsCopies )
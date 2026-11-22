helpers - debugger
probesOfTheDebugger
	"Answer the probes that the debugger steps, each with the selector of its capture and its answer: a k invoked twice, a ^ from each invocation, a handler slice, detect:ifNone: and a re-entry of callcc."

	| n |
	n := 0.
	^ {
		  {
			  #shift.
			  [ 1 + [ 10 + ([ :k | k value: (k value: 100) ] shift) ] reset ].
			  121 }.
		  {
			  #shift.
			  [ [ self returnOfTwoShots + 1 ] reset ].
			  32 }.
		  {
			  #shift.
			  [ [ ([ 1 / 0 ] on: ZeroDivide do: [ :e | [ :k | (k value: 1) + (k value: 2) ] shift ]) * 10 ] reset ].
			  30 }.
		  {
			  #shift.
			  [ [ #( 1 2 3 ) detect: [ :x | [ :k | (k value: true) + (k value: false) ] shift ] ifNone: [ 0 ] ] reset ].
			  6 }.
		  {
			  #callcc.
			  [
			  [
			  | kc r |
			  r := #( 1 2 3 ) detect: [ :x |
				       ([ :k |
				        x = 2 ifTrue: [ kc := k ].
				        x ] callcc) = 2 ].
			  n := n + 1.
			  n < 3 ifTrue: [ kc value: 2 ].
			  {
				  r.
				  n } ] reset ].
			  #( 2 3 ) } }
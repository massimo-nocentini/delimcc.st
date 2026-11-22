*Delimcc
callcc
	"Evaluate me with k, the rest of the computation up to the nearest #reset, and answer what I answer.

The rest is copied when I am called, and I run on the original stack, in the continuation of callcc: the non-local returns and the exception handlers around me keep working, and a #shift inside me captures the code that follows me, as it does with Scheme48's

```
  (define cwcc
    (lambda (p)
      (shift k (k (p (lambda (x)
                       (shift k1 (k x))))))))
```

While I run, k value: x makes callcc answer x at once. Once callcc has answered, k value: x drops the computation up to its nearest #reset and runs a copy of the rest with x instead, so invoking k again re-runs the code that follows callcc.
Each call copies the contexts down to the #reset, so it costs as much as their number.
With no #reset around me, I delimit myself, and k can only escape from me.
"

	| delimiter k |
	delimiter := (DelimccPrompt reset delimiterFrom: thisContext sender)
		             ifNil: [ ^ [ self callcc ] reset ].

	k := PartialContinuation new
		     from: (thisContext sender copyTo: delimiter sender) downTo: nil;
		     yourself.

	^ self value: [ :x |
		  (thisContext hasSender: thisContext home)
			  ifTrue: [ ^ x ]
			  ifFalse: [ [ :k1 | k value: x ] shift ] ]
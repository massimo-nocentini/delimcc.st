*Delimcc
callcc
	"
The following code is taken from Scheme48 implementation:

```
  (define cwcc
    (lambda (p)
      (shift k (k (p (lambda (x)
                       (shift k1 (k x))))))))
```

Since #shift is shift0, each body of a shift above runs inside an explicit #reset, as it would with shift.
The continuation k reaches the nearest #reset around me, so invoking it again re-runs the code that follows me there.
With no #reset around me, I delimit myself and k can only escape from me.
"

	(DelimccPrompt reset delimiterFrom: thisContext sender) ifNil: [
		^ [ self callcc ] reset ].

	^ [ :k |
	  [ k value: (self value: [ :x | [ :k1 | [ k value: x ] reset ] shift ]) ]
		  reset ] shift
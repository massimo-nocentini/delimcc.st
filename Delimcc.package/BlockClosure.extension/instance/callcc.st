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

"

	^ [ :k | k value: (self value: [ :x | [ :k1 | k value: x ] shift ]) ]
		  shift
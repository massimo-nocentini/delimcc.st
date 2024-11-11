*Delimcc
bucket

	| memo f |
	memo := Dictionary new.

	f := [ :arg |
	     memo
		     at: arg
		     ifAbsentPut: [ [ self value: arg ] hansei inferenceExact ] ].

	^ [ :arg | (f value: arg) reflect ]
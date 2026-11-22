tests - ensure
testUnwindOfAnAbandonedGenerator
	"k is a generator over an Array, stopped at its first element: k unwind closes it, once."

	| k |
	k := [ [ #( 1 2 3 ) do: [ :x | [ :kk | kk ] shift ] ] ensure: [ log add: #closed ] ] reset.
	self assert: log isEmpty.
	k unwind.
	self assert: log asArray equals: #( #closed ).
	k unwind.
	self assert: log asArray equals: #( #closed )
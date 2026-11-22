helpers
queens: n
	"The solutions of the n queens problem, a list of columns each. placed is passed by value to #safe:row:placed:, so each invocation of k has its own."

	^ p delimit: [
		  | placed |
		  placed := #(  ).
		  1 to: n do: [ :row |
			  | column |
			  column := self choose: (1 to: n).
			  (self safe: column row: row placed: placed) ifFalse: [ p abort: #(  ) ].
			  placed := placed copyWith: column ].
		  { placed } ]
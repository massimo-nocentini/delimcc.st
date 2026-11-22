examples
examples
	"Answer the examples of the section Semantics of README.md, verbatim, in their order: scripts/readme.st checks that they are the same. Each one answers what its last line, a comment that starts with -->, shows."

	^ #(
		'| p q |
p := DelimccPrompt named: ''p''.
q := DelimccPrompt named: ''q''.
{ 1 + (p delimit: [ 10 + (p shift: [ :k | k value: (k value: 100) ]) ]).
  p delimit: [ 1 + (q delimit: [ 10 + (p shift: [ :k | k value: (k value: 100) ]) ]) ].
  1 + (p delimit: [ 10 + (p abort: 5) ]) }
"--> #(121 122 6)"'
		'| p |
p := DelimccPrompt named: ''p''.
{ [ ''a'' , [ [ :f | [ :g | '''' ] shift ] shift ] reset ] reset.
  p delimit: [ ''a'' , (p delimit: [ p shift0: [ :f | p shift0: [ :g | '''' ] ] ]) ].
  p delimit: [ ''a'' , (p delimit: [ p shift: [ :f | p shift: [ :g | '''' ] ] ]) ].
  p delimit: [ ''a'' , (p delimit: [ p control: [ :f | p control: [ :g | '''' ] ] ]) ] }
"--> #('''' '''' ''a'' ''a'')"'
		'{ [ #( 1 2 3 ) detect: [ :x | [ :k | (k value: true) + (k value: false) ] shift ] ifNone: [ 0 ] ] reset.
  [ ([ 1 / 0 ] on: ZeroDivide do: [ :e | [ :k | (k value: 1) + (k value: 2) ] shift ]) * 10 ] reset }
"--> #(6 30)"'
		'| cell |
cell := Array with: 0.
{ [ | x | x := 0. [ :k | (k value: 1) + (k value: 1) ] shift. [ x := x + 1 ] value. x ] reset.
  [ [ :k | (k value: 1) + (k value: 1) ] shift. cell at: 1 put: (cell at: 1) + 1 ] reset }
"--> #(2 3)"'
		'| log k |
log := OrderedCollection new.
k := [ [ [ :kk | kk ] shift ] ensure: [ log add: #ensure ] ] reset.
log add: #captured.
k value: 1.
k value: 2.
k unwind.
k := [ [ #( 1 2 3 ) do: [ :x | [ :kk | kk ] shift ] ] ensure: [ log add: #closed ] ] reset.
k unwind.
log asArray
"--> #(#captured #ensure #ensure #closed)"'
		'[ | m kc | m := [ :k | kc := k. 0 ] callcc. m < 3 ifTrue: [ kc value: m + 1 ]. m ] reset
"--> 3"' )
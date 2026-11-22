tests - derived
testDanvyFilinskiProbe
	"Shan's probe tells the four operators apart by whether the block and k are delimited. The legacy shift answers '', as shift0 does."

	self assert: (p delimit: [ 'a' , (p delimit: [ p shift: [ :f | p shift: [ :g | '' ] ] ]) ]) equals: 'a'.
	self assert: (p delimit: [ 'a' , (p delimit: [ p control: [ :f | p control: [ :g | '' ] ] ]) ]) equals: 'a'.
	self assert: (p delimit: [ 'a' , (p delimit: [ p shift0: [ :f | p shift0: [ :g | '' ] ] ]) ]) equals: ''.
	self assert: (p delimit: [ 'a' , (p delimit: [ p control0: [ :f | p control0: [ :g | '' ] ] ]) ]) equals: ''.
	self assert: [ 'a' , [ [ :f | [ :g | '' ] shift ] shift ] reset ] reset equals: ''
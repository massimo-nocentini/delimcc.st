helpers
choose: aCollection
	"Multi-shot amb: invoke k with each element and concatenate the lists of solutions."

	^ p shift: [ :k | aCollection inject: #(  ) into: [ :solutions :each | solutions , (k value: each) ] ]
helpers
generatorProduce: wrapBlock jump: aSelector
	"The producer of #generatorValues:jump:do:."

	wrapBlock value: [
		1 to: 3 do: [ :each |
			Continuation currentDo: [ :producer |
				k := producer.
				tmp perform: aSelector with: each ] ] ].
	tmp perform: aSelector with: #done
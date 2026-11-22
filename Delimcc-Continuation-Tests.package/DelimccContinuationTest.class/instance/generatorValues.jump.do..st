helpers
generatorValues: wrapBlock jump: aSelector do: eachBlock
	"Answer the values of a generator made of two continuations: k resumes the producer, tmp returns to the consumer, and both jump with aSelector. The producer yields 1, 2 and 3 from inside wrapBlock, which gets the loop as a block to evaluate, and then #done. eachBlock gets each value as the consumer receives it."

	| value values |
	k := nil.
	values := OrderedCollection new.
	[
	value := Continuation currentDo: [ :consumer |
		         tmp := consumer.
		         k
			         ifNil: [ self generatorProduce: wrapBlock jump: aSelector ]
			         ifNotNil: [ k perform: aSelector with: nil ] ].
	values add: value.
	eachBlock value: value.
	value ~~ #done ] whileTrue.
	^ values asArray
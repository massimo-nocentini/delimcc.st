private - prototype
ablate: aCollection
	"Turn off the rules named in aCollection, some of #receivers #closureOrNil #closures #exceptions #vectors, in every copier made from now on; an empty collection turns them all on again. For the ablation runs of the prototype only."

	Ablated := aCollection ifEmpty: [ nil ]
"Benchmarks of the continuations of Delimcc, not loaded by the baseline.
Run it in an image where Delimcc and Delimcc-Tests are loaded, for example
  pharo --headless X.image --no-default-preferences st --quit scripts/bench.st
It prints one line per benchmark, the best of DCC_REPS runs (5 by default) in ms, after a warm-up run.
Compare two versions by running it in an image of each one, on a quiet machine, pinned to one core (taskset -c N).
B1-B9 are those of the review fixes, P1-P7 those of the copy-on-reuse experiment."
| log reps best deep k subject |
log := [ :line | Stdio stdout nextPutAll: line asString; lf; flush ].
reps := (OSEnvironment current at: 'DCC_REPS' ifAbsent: [ '5' ]) asNumber.
best := [ :label :aBlock |
	| times |
	aBlock value.
	times := (1 to: reps) collect: [ :i |
		| start |
		Smalltalk garbageCollectMost.
		start := Time microsecondClockValue.
		aBlock value.
		Time microsecondClockValue - start ].
	log value: 'BENCH ' , label , ' ' , ((times inject: times first into: [ :a :b | a min: b ]) / 1000.0 printShowingDecimalPlaces: 1) , ' ms' ].
subject := (Object << #DelimccBenchSubject slots: {}; package: 'DelimccBench') install.
subject compile: 'deep: n
	^ n = 0 ifTrue: [ [ :k | k ] shift ] ifFalse: [ 1 + (self deep: n - 1) ]'.
subject compile: 'deepBlocks: n
	| r |
	n = 0 ifTrue: [ ^ [ :k | k ] shift ].
	#( 1 ) do: [ :x | r := 1 + (self deepBlocks: n - 1) ].
	^ r'.
deep := nil.
deep := [ :n :leaf | n = 0 ifTrue: [ leaf value ] ifFalse: [ 1 + (deep value: n - 1 value: leaf) ] ].
best value: 'B1 [1 + [:k | k value: 1] shift] reset x100000' value: [ 100000 timesRepeat: [ [ 1 + [ :kk | kk value: 1 ] shift ] reset ] ].
#( 10 100 1000 ) do: [ :d |
	best value: 'B2 shift ' , d printString , ' frames above reset, discard k, x' , (100000 // d) printString value: [
		(100000 // d) timesRepeat: [ [ deep value: d value: [ [ :kk | 0 ] shift ] ] reset ] ] ].
k := [ deep value: 1000 value: [ [ :kk | kk ] shift ] ] reset.
best value: 'B8 1000-frame k invoked x300' value: [ 300 timesRepeat: [ k value: 1 ] ].
k := [ deep value: 10 value: [ [ :kk | kk ] shift ] ] reset.
best value: 'B8b 10-frame k invoked x100000' value: [ 100000 timesRepeat: [ k value: 1 ] ].
best value: 'B9 hansei flip chain (10 flips) x20' value: [
	20 timesRepeat: [ [ (1 to: 10) inject: true into: [ :a :i | a xor: (true bernoulli: 1 / 2) ] ] hansei inferenceExact ] ].
k := [ subject new deep: 1000 ] reset.
best value: 'P1 1000-frame k, 300 shots' value: [ (1 to: 300) inject: 0 into: [ :a :i | a + (k value: 1) ] ].
k := [ subject new deepBlocks: 300 ] reset.
best value: 'P2 900 frames + 300 closures + 300 vectors, 300 shots' value: [ (1 to: 300) inject: 0 into: [ :a :i | a + (k value: 1) ] ].
best value: 'P3 10000 x capture + 1 shot' value: [ (1 to: 10000) inject: 0 into: [ :a :i | a + [ 1 + ([ :kk | kk value: i ] shift) ] reset ] ].
best value: 'P4 10000 x capture + 2 shots' value: [
	(1 to: 10000) inject: 0 into: [ :a :i | a + [ 1 + ([ :kk | (kk value: i) + (kk value: 1) ] shift) ] reset ] ].
best value: 'P5 10000 x capture, k discarded' value: [ (1 to: 10000) inject: 0 into: [ :a :i | a + [ 1 + ([ :kk | i ] shift) ] reset ] ].
best value: 'P6 hansei xor of 12 flips' value: [
	([ (1 to: 12) inject: false into: [ :a :i | a ~= (true bernoulli: 1 / 2) ] ] hansei inferenceExact) asValuesDictionary ].
best value: 'P7 HanseiTest suite' value: [ HanseiTest suite run ]
handling
answer: aBlock
	"Return from my handler the value of aBlock times 10, through a block of mine that exists before aBlock runs."

	^ [ :x | self return: x * 10 ] value: aBlock value
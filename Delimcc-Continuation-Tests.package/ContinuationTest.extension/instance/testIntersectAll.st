*Delimcc-Continuation-Tests-tests
testIntersectAll

	| sets |
	self
		assert: (self intersectAll: {
					 (LinkedList with: 3 with: #mangos with: #and).
					 (LinkedList with: 3 with: #kiwis with: #and).
					 (LinkedList with: 3 with: #hamburges) })
		equals: { 3 }.
	self
		assert: (self intersectAll: {
					 (LinkedList with: 3 with: #steaks with: #and).
					 (LinkedList with: #no with: #food with: #and).
					 (LinkedList with: #three with: #baked with: #potatoes).
					 (LinkedList with: 3 with: #diet with: #hamburges) })
		equals: {  }.
	self
		assert: (self intersectAll: {
					 (LinkedList with: 3 with: #steaks with: #and).
					 LinkedList new.
					 (LinkedList with: #three with: #baked with: #potatoes).
					 (LinkedList with: 3 with: #diet with: #hamburges) })
		equals: {  }.
	sets := {
		        (LinkedList with: 3 with: #steaks with: #and).
		        LinkedList new.
		        (LinkedList with: #three with: #baked with: #potatoes).
		        (LinkedList with: 3 with: #diet with: #hamburges) }.
	"hop answers the empty set itself, without intersecting the sets before it"
	self assert: (self intersectAllWithCC: sets) == sets second.
	self
		assert: (self intersectWithCCAllWithCC: {
					 (LinkedList with: 3 with: #steaks with: #and).
					 (LinkedList with: #no with: #food with: #and).
					 (LinkedList with: #three with: #baked with: #potatoes).
					 (LinkedList with: 3 with: #diet with: #hamburges) })
		equals: {  }
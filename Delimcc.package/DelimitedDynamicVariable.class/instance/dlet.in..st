controlling
dlet: anObject in: aBlock
	"Bind me to anObject while aBlock is evaluated, and answer its value. See DelimitedDynamicVariableRef for how the binding is found."

	^ (DelimitedDynamicVariableRef dynVar: self newValue: anObject) during: aBlock
private
applies: aRule
	"Answer whether aRule is on. The callers test first whether ablated is nil, as it is outside the ablation runs of the prototype, so that they need no send then."

	^ (ablated includes: aRule) not
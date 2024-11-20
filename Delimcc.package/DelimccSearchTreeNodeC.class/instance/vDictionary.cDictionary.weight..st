exploring
vDictionary: d cDictionary: c weight: p

	| v |
	v := c at: self slot ifAbsent: 0.
	c at: self slot put: v + p
exploring
vDictionary: d cDictionary: c weight: p

	| v |
	v := d at: self slot ifAbsent: 0.
	d at: self slot put: v + p
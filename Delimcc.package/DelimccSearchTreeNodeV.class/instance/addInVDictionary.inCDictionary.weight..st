exploring
addInVDictionary: d inCDictionary: c weight: p

	| v |
	v := d at: self slot ifAbsent: 0.0.
	d at: self slot put: v + p
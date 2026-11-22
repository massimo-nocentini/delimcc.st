private
freezeVector: anArray
	"Copy anArray, a temp vector of one of my contexts, and the exceptions that it holds."

	self freeze: anArray.
	1 to: anArray size do: [ :i | (anArray at: i) freezeDelimcc: self ]
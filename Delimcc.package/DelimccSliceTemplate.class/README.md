I am the template of a slice of the stack, which DelimccSliceCopier made from the contexts of a PartialContinuation before their first invocation: copies of the contexts, top first, chained, the bottom one with no sender, copies of the objects that belong to them (closures, exceptions and temp vectors), and the patches that re-point their references to each other.

#instantiate answers fresh copies of my contexts for another invocation: it copies each context and object, chains the contexts and applies my patches, with no scan and no lookup. My own contexts never run.

A patch is three integers: the code of the holder, the field, and the code of the target. A code is the index of a context, positive, or minus the index of an object. A field is the index of an instance variable, positive, or minus the index of a stack slot or of an indexed slot.

I am plain when I have no patch: nothing in my contexts refers to another of them, and #instantiate only copies and chains them.
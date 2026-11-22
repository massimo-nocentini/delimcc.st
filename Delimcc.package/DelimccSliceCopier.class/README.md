I make the DelimccSliceTemplate of a slice of the stack, the contexts of a PartialContinuation, top first, the bottom one with no sender: a copy of them, and of the objects that belong to them, whose references to each other are re-pointed to the copies, plus the list of these references, so that the template can make further copies without me.

The rules, each of which some test of DelimccSliceTest needs:
- R1 the copies of the contexts are chained as the contexts are;
- R2 the receiver (#codeOfReceiver:), the closure (#codeOfClosureOfFrame:) and the stack slots of each context, temporaries and operands, are re-pointed;
- R3 a closure (FullBlockClosure and its subclasses) is copied when its outer context, its receiver or one of its copied values has a copy (#codeOfClosure:); clean blocks are shared otherwise;
- R4 an exception is copied when an instance variable refers to one of the contexts (signalContext, handlerContext, outerContext), and then all of them are re-pointed, so that resume:, return:, pass, outer and retry of a copy act on the copies (#codeOfException:);
- R5 a temp vector that a context of the slice has created, as DelimccTempVectorScanner finds it, is copied, so the temporaries of a frame are copied with it whatever the compiler did with them (#codeOfArray:);
- R6 a context of the slice that a slot holds, thisContext stored in a temporary, is re-pointed;
- R7 everything else is shared: the prompt, the receivers of the methods, the collections and other heap objects, the dynamic variables, and the closures and temp vectors of the contexts below the slice. A closure that a heap object holds is not re-pointed, so its ^ works in the first invocation only.

#templateSharingTempVectorsOf: turns R5 off: the temp vectors are shared by the copies and by the contexts themselves, as callcc needs, since its contexts keep running.

The code of a copy is the index of its context, positive, or minus the index of its object; 0 means shared. Each object answers it to #sliceCodeDelimcc:, which dispatches on its kind. The contexts are fixed from the bottom up, so the temp vectors of a context are known before the contexts above it, which may refer to them, are fixed. The references are fixed once every context is.
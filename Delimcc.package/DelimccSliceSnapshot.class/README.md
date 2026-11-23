I am the template of a slice of the stack deeper than 16 contexts before it is fixed (`DelimccSliceCopier class>>#templateOf:`): what `DelimccSliceCopier` needs of the slice, taken when the first invocation of its `PartialContinuation` begins, before that invocation runs the contexts themselves.

I hold:

- plain copies of the contexts, top first, chained, the bottom one with no sender,
- and shallow copies of the objects that the invocation may change and that the copier copies: the temp vectors that the contexts have created (`DelimccTempVectorScanner`) and the exceptions that are their receivers or that these vectors hold (`#freezeDelimcc:`).

An exception that the first invocation signals, passes, handles or goes outer with is the receiver of one of the contexts. Taking me costs little more than one plain copy of the contexts.

At my first `#instantiate`, the second invocation, I make the `DelimccSliceTemplate` of the slice with the copier, from a copy of my copies, the contexts and objects of the slice being mapped to my copies of them, so it is the template that the first invocation would have made. So a continuation invoked once, as by a generator, never pays the copier, while one invoked twice pays a snapshot and a copy more. Making the template changes none of my copies: two processes that make it at once make equal templates, and I keep the first.

An exception that only a slot or a closure of the slice holds, which the first invocation can change only by signalling it again, is read by the copier as that invocation has left it.
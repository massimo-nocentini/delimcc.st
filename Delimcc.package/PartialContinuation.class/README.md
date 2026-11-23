I am a slice of a call stack, the contexts that a capture cut off the stack down to a delimiter of my `#prompt`, a `DelimccPrompt`. The capture cuts my bottom context off its sender, so I do not hold the stack below the delimiter. Use me like a block with `#value` or `#value:`, or with `#pushSubCont:`, which run my contexts on top of the current call stack. I can be invoked many times.

## Invocations

The first invocation runs my own contexts, the ones that the capture cut off the stack, so it is exactly the computation that the capture interrupted: closures keep their homes, exceptions their handlers. It signals a `DelimccResumedSliceError` instead when something has resumed them since the capture, as a `Continuation` captured inside my delimiter before the capture does when it is invoked: I keep my bottom context until then, to tell.

Before it runs them, it keeps a `DelimccSliceTemplate` of them, made by `DelimccSliceCopier`, and drops them; for a slice deeper than 16 contexts, it keeps a `DelimccSliceSnapshot` of them instead, a plain copy, which the second invocation fixes into the template, so that a continuation invoked once never pays the copier.

Each later invocation runs fresh copies from the template, in which the closures, the exceptions, the temp vectors and the contexts of the slice refer to the copies of each other, not to the contexts of another invocation: a `^` in a block of the slice returns from the copy of its home, and a handler of the slice handles, resumes, retries and returns in the copy.

## Temporaries and heap objects

So the temporaries of my contexts are copied with them at each invocation, as they were at the first one, whether the compiler kept them in the contexts or in temp vectors; only heap objects (instance variables, collections, a `ValueHolder`, a dynamic variable) are shared by the invocations, as the heap is in Kiselyov's delimcc. A closure that a heap object holds is not re-pointed, so a `^` in it works in the first invocation only.

## callcc

callcc makes me from a copy of contexts that go on running (`#prompt:copying:upTo:`): my first invocation makes my template from that copy, re-pointing the references to the running contexts, and every invocation runs a fresh copy of it. These copies share the temp vectors of the running contexts, as callcc in Scheme shares the variables. When one of these contexts runs an exception handler, callcc makes my template at once instead, so that the copies handle the exception as it was then, not as the running contexts have changed it since (`pass`, `outer`, `signal`).

## Unwind blocks

A capture runs no unwind block, and neither does a continuation that is never invoked; each invocation that completes or is unwound runs the `ensure:` and `ifCurtailed:` blocks of its own contexts once, as delimcc does. `#unwind` runs those of a continuation that has never been invoked and never will be, such as an abandoned generator. It takes the place of my first invocation, so I can still be invoked afterwards, with a fresh copy, on the state that the unwind blocks have left.
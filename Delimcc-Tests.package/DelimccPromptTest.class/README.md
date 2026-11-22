I exercise the multi-prompt core of DelimccPrompt and PartialContinuation, after Dybvig, Peyton Jones and Sabry: p and q are two independent prompts. The examples are the classic ones of the literature: Shan's probe of the four operators, the traversal of Biernacki, Danvy and Shan, multi-shot amb, and same fringe with two generators on two prompts.

Three tests are expected failures, because they need copies of a slice whose closures and exceptions are re-pointed to the copies, which plain copies are not (WP2 of the proto-multiprompt branch):
- testNonLocalReturnFromKInDetect and testNonLocalReturnFromKInAnySatisfy (review #1): the ^ of the copy of a block finds its home in the original contexts, and raises BlockCannotReturn;
- testShiftInsideAHandlerResumesItsCopies (review #2): the copy of a handler returns through its exception to the original on:do:, which is off the stack, so it falls off the original contexts.

#isolated: runs them in a process of their own, whose error handler is me, because what review #2 raises is out of reach of every handler of the caller.
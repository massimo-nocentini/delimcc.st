I am a prompt of the multi-prompt core of delimited control of Dybvig, Peyton Jones and Sabry: DelimccPrompt new is newPrompt, and #named: gives a name to print. My instances are independent of each other, and a capture to one of them goes through the delimiters of the others.

- p delimit: aBlock is pushPrompt: it evaluates aBlock delimited by me, and its context is the delimiter.
- p withSubCont: [ :k | ... ] is withSubCont: it cuts the contexts from its sender down to my nearest delimiter off the stack, the delimiter too, reifies them as a PartialContinuation k without the delimiter, and answers what the block answers to the sender of the delimiter.
- k pushSubCont: aBlock is pushSubCont, and k value: x is k pushSubCont: [ x ].
- p isDelimiting is is_prompt_set of Kiselyov's delimcc.

#delimiterFrom: finds the nearest delimiter of mine by walking the senders and comparing the receiver by identity and the selector, not the method, so that recompiling #delimit: does not invalidate the continuations captured before. No exception is signalled to find a delimiter, so no handler between a capture and its delimiter, however generic (on: Exception do:, on: Notification do:), can intercept it. A capture without a delimiter signals MissingResetException, which names me, and changes nothing.

BlockClosure>>#reset delimits with the prompt that my class answers to #reset.
I exercise the slices of the stack that a PartialContinuation runs: its own contexts at the first invocation, fresh copies from its DelimccSliceTemplate afterwards, made by DelimccSliceCopier, with the temp vectors that DelimccTempVectorScanner finds. Most probes are those of review #1 (a ^ in a block of the slice) and #2 (a shift inside an exception handler), ported from the experiments of the proto-multiprompt branch, and run isolated, as they ended the run before.

Each rule of DelimccSliceCopier is needed by the tests that fail when DelimccSliceCopier class>>#ablate: turns it off:
- R2, receivers: testShiftInsideAHandler, testHandlerSliceAfterItsReset, testHandlerSliceInOtherProcesses, testRetryAfterReentry;
- R2, closures of the contexts: testNonLocalReturnFromEachShot, testNonLocalReturnFromKAfterItsReset, testAnySatisfyOfThreeShots, testThousandShotsOfNonLocalReturns, testDeepSliceOfNonLocalReturns, testEnsureOncePerShot, testHanseiModelWithDetect, testProcesses;
- R3, closures: the same, plus testDetectIfNoneOfTwoShots, testSliceClosureCapturedByAReturnedMethod and testRetryAfterReentry;
- R4, exceptions: testResumeAndReturnInAHandlerSlice, testPassAndOuterAfterReentry, testRetryAfterReentry, testErrorOfASecondShotInsideTheSlice, testErrorOfASecondShotOutsideTheSlice;
- R5, temp vectors: testTempsArePerShot, testTempsWrittenByABlockArePerShot, testAssignmentOfAFirstShotIsNotSeenByTheNext, testRetryAfterReentry.

The limits are pinned too: a closure that a heap object holds is not re-pointed (testClosureHeldByAHeapObject), and a temporary of the slice that the first invocation assigns is not seen by the later ones (testAssignmentOfAFirstShotIsNotSeenByTheNext).
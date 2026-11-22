helpers
handleError: anError
	"I am the error handler of the processes of #isolated:: anError is their outcome, and it ends them."

	outcome := anError.
	isolation signal.
	Processor activeProcess terminate
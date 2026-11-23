I am the baseline of [Delimcc](https://github.com/massimo-nocentini/delimcc.st), delimited control operators for Pharo. My packages:

- `Delimcc`: the prompts, `reset`, `shift` and `callcc`, the delimited dynamic variables, and Hansei's search trees;
- `Delimcc-Tests`: its tests;
- `Delimcc-Continuation`: extension methods that fix Pharo's own `Continuation`;
- `Delimcc-Continuation-Tests`: the tests of `Delimcc-Continuation`, and extension methods that fix those of `Continuation`.

By default I load all of them; the group `Continuation` is the last two alone, which `Delimcc` does not need. `Delimcc` requires the projects `ContainersEssentials` and `ContainersCategory`.

```smalltalk
Metacello new
	baseline: 'Delimcc';
	repository: 'github://massimo-nocentini/delimcc.st:master';
	load
```
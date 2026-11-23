I am a search tree of HANSEI: a probability distribution, as the weighted branches that a model has at one of its choices. My `children` are a chain of ValueLinks, nil when I am empty, of DelimccWeightedValues: the weight of a branch and its `DelimccSearchTreeNode`, a value of the model (`DelimccSearchTreeNodeV`) or the rest of the model, not run yet (`DelimccSearchTreeNodeC`).

## Making

A model is a block that makes its choices with `bernoulli:`, `bernoulli:otherwise:` and `chooseShift`, and keeps only some of the outcomes with `when:`. `BlockClosure>>#hansei` runs it up to its first choice and answers me; `#hanseiSuspended` runs nothing yet. `asSearchTree` makes me from a collection, with uniform weights, or from a `Dictionary` of values and weights.

```smalltalk
| tree |
tree := [
	| x y |
	x := true bernoulli: 1 / 2.
	y := true bernoulli: 1 / 2.
	x | y when: [ x ] ] hansei.
tree inferenceExact asValuesDictionary first
"a Dictionary(false->(1/4) true->(1/2) )"
```

## Exploring

- `inferenceExact` runs every branch, and `inferenceUpToDepth:` those up to a depth. Both answer another tree, in which the weights of equal values have been added up.
- `asValuesDictionary` answers two Dictionaries: the weights of the values among my children, and those of the branches not run yet. `asValuesDictionaryNormalized: true` divides them by their sum, unless it is zero, and `mean`, or `average`, is the first of the two then.
- `reflect`, inside another model, makes my outcomes a choice of that model; `BlockClosure>>#bucket` uses it to explore a function of a model once for each argument.
- `asPresenter` shows me in a tree presenter.

I am a monad too (`TCTMonadCategory`): `return:` is a tree of one value, `>>=` goes on from each value with a block, and `fail:` is the empty tree.
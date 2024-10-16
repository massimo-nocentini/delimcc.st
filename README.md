# delimcc.st
A port of http://www.squeaksource.com/Control for Pharo Smalltalk.

Load with:
```smalltalk
Metacello new
    baseline: 'Delimcc';
    repository: 'github://massimo-nocentini/delimcc.st';
    load
```

## Description
This project demonstrates an implementation of the shift/reset control operators used for constructing and evaluating partial continuations. It owes a great deal to the extensive literature on the subject, but in particular to [Final Shift for Call/cc: Direct Implementation of Shift and Reset](https://www.researchgate.net/publication/2546665_Final_Shift_for_Callcc_Direct_Implementation_of_Shift_and_Reset), by Martin Gasbichler and Michael Sperber, and to Seaside's Flow package, from which I "borrowed" serialisation/deserialisation, and learned how to stitch a partial continuation onto the current stack.

## Attribution
The work is by 	Frank Shearar and	Levente Uzonyi, I just loaded in Pharo and did a little fix to make tests green.


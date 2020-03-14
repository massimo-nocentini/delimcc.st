# shift-reset-st
A port of http://www.squeaksource.com/@WEndVc8Glnss6sO7/T9RwN4wq for Pharo Smalltalk

## Description
This project demonstrates an implementation of the shift/reset control operators used for constructing and evaluating partial continuations. It owes a great deal to the extensive literature on the subject, but in particular to [Final Shift for Call/cc: Direct Implementation of Shift and Reset](http://www-pu.informatik.uni-tuebingen.de/users/sperber/papers/shift-reset-direct.pdf), by Martin Gasbichler and Michael Sperber, and to Seaside's Flow package, from which I "borrowed" serialisation/deserialisation, and learned how to stitch a partial continuation onto the current stack.

## Attribution
The work is by 	Frank Shearar and	Levente Uzonyi, I just loaded in Pharo and did a little fix to make tests green.


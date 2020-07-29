TODO
====

(Note, some of these are possibly long-term plans.)

Disjointness of types
---------------------

Insofar as the types of Robin are disjoint, we can have a
`typeof` intrinsic which returns a literal symbol such as
`number`, `list`, and so forth, instead of _n_ predicates.
In practice the predicates are useful, and would be retained
in the stdlib.  But this could make the set of intrinsics smaller.

Opaque type
-----------

Values of "opaque" type.  Intrinsics `wrap` and `unwrap`.  But note
that only the functions implementing the ADT are guaranteed to be able
to unwrap an opaque value, and those functions might be implemented
natively, rather than as Robin code that uses `wrap` and `unwrap`.

Then, can we provide environments as an abstract type?  We would
also provide `env->alist` and `alist->env` so they can be worked
with easily.  But they could be used natively to support symbol
lookup, and if they are implemented as trees or hash tables, this
might have performance benefits.  (Or perhaps not.)

Opaque type might also be useful for internals, e.g. signaling
to runtime system that an error occurred.

Stdlib
------

`(compose f1 f2)` composes two functions.

`(sgn x)`

`(modulo x y)` which is always positive, change `remainder` to
be sign of divisor (like R6RS.)

Other libs
----------

`schemeish` lib, that just gives you all the old jargon-y names
as aliases.

Static analysis lib.  This is its own bucket of worms.  It should
expose a macro that can be wrapped around an arbitrary standard
Robin program _p_ and, if static analysis of _p_ is successful,
simply evaluates to whatever _p_ evaluates to.  And if not
successful, produces an abort.  Should probably start small --
statically check the arity of every application, for instance.
Note that this relies on the assumption that all standard symbols
have their standard meanings.

TopLevel
--------

`rename` form.

Testing
-------

Some way to make it easier to test reactive programs, i.e.
some way to provide mock facilities.

Reactors
--------

Perhaps namespace each event name.

A more involved environment, with more facilities than just
`line-terminal`.  Multiplexed I/O would be a start, could write an
IRC client.  Could also define an environment for web pages.

For that matter, `HasteMain.hs` should inject facilities that
only make sense in the HTML5 DOM.

Subscription and unsubscription from facilities using standard commands.

Example programs
----------------

Hunt the Wumpus.

Implementation of a concatenative language in an idiomatic style,
taking a list like `(1 2 + 3 *)` and folding `compose` over it to
obtain a function, and applying that function.

Rename
------

Rename "small" to "base".

Rename `fun` to `function`.  This is because Robin prefers full words
over abbreviations, which are jargon-y.

Distribution
------------

Probably need to bite the bullet and add a `cabal` or `stack`
package descriptor.

    cabal install random-1.1
    cabal install parsec-3.1.1
    cabal install QuickCheck-2.13.2

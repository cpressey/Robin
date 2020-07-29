Robin
=====

_Version 0.8.  Work-in-progress, subject to change._

Overview
--------

**Robin** is an [excessively principled](doc/Rationale.md)
and [thoroughly specified](doc/Robin.md) functional programming language with
[eager evaluation, latent typing, and a homoiconic syntax](#scheme),
based on a [radically simple core semantics](#forth) in which
[the macro, rather than the function, is the fundamental abstraction](#picolisp).

Expressions in Robin are [referentially transparent](#haskell); programs
interact with the outside world [through an event-driven framework](#elm).

For more information, see the [extended description](#extended-description)
below.

Quick Start
-----------

The Robin reference interpreter is written in about 1300 lines of Haskell.
To use it, you'll need an implementation of Haskell installed (typically either
`ghc` or Hugs).

If you have [shelf][] installed, you can just run `shelf_dockgh catseye/Robin`.

If not, you can clone this repository, `cd` into the repo directory, and run

    ./build.sh

to build the reference interpreter.  (If you don't have `ghc`, no executable will
be built, but the `bin/robin` script will use `runhaskell` or `runhugs` instead.)

You can then run it on one of the example Robin sources in `eg` like so:

    bin/robin eg/hello-world.robin

You should see

    Hello, world!

To continue learning to program in Robin you can follow
[The Robin Tutorial](doc/Tutorial.md).

Testing
-------

If you have a few minutes to spare, and you have [Falderal][] installed,
you can run the test suite (consisting of more than 400 unit tests) by running

    ./test.sh

The tests that use only Robin's core semantics (`--no-builtins` flag) are quite
slow, so you may want to skip them.  You can skip them by running

    APPLIANCES="appliances/robin.md" ./test.sh

The test suite will also run some property tests (using QuickCheck).  Notably,
for every macro that is defined multiple times (which includes much of stdlib,
where the core definitions are written in Robin but also implemented in Haskell
as "builtins" in the reference interpreter), QuickCheck will attempt to falsify
the assertion that the definitions define the same macro.  These attempts are
currently rather crude; there is lots of room for improvement for them in some
future release.

Extended Description
--------------------

For experienced programmers, Robin might be best described by listing
the languages that have had the strongest influences on it:

### Scheme ###

Like [Scheme][], Robin is eagerly evaluated, latently typed, and homoiconic,
as well as properly tail-recursive and lexically scoped (at least by default),
and tries hard to be well-defined and system-agnostic, but (as you can read
below) diverges significantly from Scheme in other ways.

### Forth ###

Like [Forth][], Robin has a radically simple core semantics.  There are 15
intrinsic operations; every symbol in the standard library is defined in terms
of these intrinsics, while an implementation is free to provide its own
(perhaps more efficient) implementation of any such symbol.  (See also
[Pixley][]).

### PicoLisp ###

[PicoLisp][] allows defining functions with unevaluated arguments.
Robin adopts this kind of function for the basis of what it calls a `macro`,
and builds everything else on top of `macro`s.  (There *is* a `function` form
in Robin, but it's defined as a `macro`!)  This is much like how the [Kernel][]
programming language builds everything from [fexpr][]s; however, Robin was
developed oblivious of Kernel — it adapted the idea directly from PicoLisp.

### Haskell ###

Like [Haskell][], Robin is referentially transparent (often described as
"purely functional") — mutation of values is forbidden.  (Robin intentionally
does not, however, adopt lazy evaluation or a static type system.)

### Elm ###

Interactive programs in Robin are built by composing transducers which are driven
by events and produce effects (which are modelled as further events), in a
manner very similar to [The Elm Architecture][].

### Bourne shell ###

Arbitrary text can by embedded in a Robin program using a syntax
very much like a ["heredoc"](https://en.wikipedia.org/wiki/Here_document),
except it is an S-expression.

### English ###

Deserves at least a passing mention here, as one thing that Robin
discards from Scheme is its jargony terminology: no `cdr`, no `cons`,
no `lambda`.

For a full description of the Robin language, see
[the Robin specification document](doc/Robin.md).

Repository Layout
-----------------

*   appliances/ — test appliances for the literate test suite.
*   bin/ — driver script, destination for executable when built.
*   demo/ — contains HTML5 document demonstrating build to JS by Haste.
*   [doc/](doc/README.md) — Tutorial, specification, rationale, etc.
*   eg/ — example programs written in Robin
*   src/ — Haskell source for reference interpreter.
*   stdlib/ — normative definitions of standard library symbols.
*   [HISTORY.md](HISTORY.md) — history of this distribution.
*   [TODO.md](TODO.md) — plans.

[Scheme]:    http://schemers.org/
[Haskell]:   https://www.haskell.org/
[fexpr]:     https://en.wikipedia.org/wiki/Fexpr
[PicoLisp]:  http://picolisp.com/
[Kernel]:    http://web.cs.wpi.edu/~jshutt/kernel.html
[Forth]:     https://en.wikipedia.org/wiki/Forth_(programming_language)
[Pixley]:    https://catseye.tc/node/Pixley
[Elm]:       https://elm-lang.org/
[The Elm Architecture]: https://guide.elm-lang.org/architecture/
[shelf]:     https://catseye.tc/node/shelf
[Falderal]:  https://catseye.tc/node/Falderal
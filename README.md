Robin
=====

_Version 0.3.  Work-in-progress, subject to change._

Robin is a homoiconic S-expression-based language (similar to, for example,
[Scheme][], with influences from [Pixley][] and [PicoLisp][]) with the
following features:

*   The _macro_ (rather than the function) as the fundamental abstraction
    mechanism.  There is a function form, but it's defined as a macro!
*   A very small set of built-in operations.
*   A very small reference implementation in Literate Haskell
    (about 600 lines of code, excluding the explanatory prose.)
*   A fairly rich standard library of macros built on top of those built-in
    operations.  (Thus it can be used as either a "low-level" or "high-level"
    language.)
*   A fairly rich test suite (about 460 test cases.)
*   An almost zealous system-agnosticism.
*   An almost zealous disdain for escape characters.  Robin's string syntax
    never needs them (it's more like a lightweight "heredoc".)
*   A module system (which is rather fast-and-loose, so it's perhaps not
    fair to call it a module system.  It's more like C's `#include`s —
    except it's zealously system-agnostic.  And actually we're still working
    out the details here.  See the file [doc/Modules.md](doc/Modules.md).)
*   A(n attempt at) a clean separation of evaluation (no "side-effects") and
    execution (with "side-effects" and system interaction) by the use of
    _reactors_ (which are basically event handlers.)  See the file
    [doc/Reactor.md](doc/Reactor.md) for more information.

Quick Start
-----------

You'll need either `ghc` or Hugs installed.

Clone this repo and `cd` into it, and run `./build.sh` to build the reference
interpreter `bin/robinri`, and the slightly-less-impractical interpreter
called `bin/whitecap` (for historical reasons, and subject to change.)

(Or if you have [shelf][], you can run `shelf_dockgh catseye/robin`.)

Testing
-------

If you have a few minutes to spare, and you have [Falderal][] installed,
you can run the test suite by running

    ./test.sh

If you want to only test the `whitecap` interpreter (much faster), you can run

    APPLIANCES="appliances/whitecap.md" ./test.sh

Documentation
-------------

Robin's fundamental semantics are documented in
[doc/Robin.md](doc/Robin.md).

History of Robin can be found in [HISTORY.md](HISTORY.md).

[Falderal]:  https://catseye.tc/node/Falderal
[PicoLisp]:  http://picolisp.com/
[Pixley]:    https://catseye.tc/node/Pixley
[Robin]:     https://catseye.tc/node/Robin
[Scheme]:    http://schemers.org/
[shelf]:     https://catseye.tc/node/shelf

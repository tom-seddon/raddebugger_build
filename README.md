This repo has submodules. Clone with `--recursive` or do `git
submodule init`, `git subomdule update` after cloning
non-recursively.

Some quick cmake nonsense to support editing and building the RAD
debugger from Visual Studio 2019, mainly to get the clickable error
messages and code browsing.

Prerequisites:

* Visual Studio 2019
* Python 3.x

One-off steps:

1. `make init` from root of working copy

Day-to-day use:

1. Load `build\vs2019\raddebugger.sln` into Visual Studio 2019

2. `Build` > `Build solution`

The build step runs `make -r -f Makefile.build.mak` from the root of
the working copy, which by default runs `bulid.bat`.

`Debug` > `Start Debugging` (etc.) are not supported.

# Emacs

The following wouldn't be the worst possible addition to a
`.dir-locals.el` file:

```
((nil . ((c-file-offsets . ((statement-case-open . 0)))
         (c-basic-offset . 2))))
```

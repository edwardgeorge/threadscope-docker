Docker image for building a relocatable threadscope binary.

Threadscope builds fine with a system GHC and latest cabal but fails utterly
to build for me using only stack, due to the gtk2hs-buildtools issue, even
when running supposed workarounds found in various github issues from
multiple projects (such as `stack install gtk2hs-buildtools` before attempting
to build, etc).

Rather than install a system ghc (which often _seems_ not to play nicely with
stack even when never using it in stack.yaml) I've created a docker image to
build threadscope under fedora24 and export the binaries.

extract the files by running:

    $ docker build -t threadscope-docker .
    $ docker run threadscope-docker | base64 -d | tar xj
    
this gives you threadscope, hp2pretty, and ghc-events binaries.

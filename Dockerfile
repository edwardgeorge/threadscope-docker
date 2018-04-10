FROM fedora:27
RUN dnf update -y
# requirements for theadscope.
# many of these get rebuilt when we attempt to build threadscope from hackage
# but they pull in the required dependencies anyway meaning cabal has to build less
RUN dnf install -y ghc cabal-install alex happy gtk2hs-buildtools ghc-gtk zlib-devel
RUN dnf install -y gtk2-devel glib2-devel pango-devel cairo-devel
RUN cabal update
# install the latest cabal-install (needed to build correctly)
RUN cabal install cabal-install
ENV PATH="/root/.cabal/bin:$PATH"
RUN cabal update
RUN cabal install --force-reinstalls threadscope hp2pretty
# now reinstall relocatable (some deps fail with this flag, so we build first above without)
RUN cabal install --enable-relocatable threadscope hp2pretty
# required packages for our command
RUN dnf install -y coreutils tar bzip2
# tar and bzip the binaries for output
CMD tar -cjC /root/.cabal bin/threadscope bin/ghc-events bin/hp2pretty | base64

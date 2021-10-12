FROM gitpod/workspace-full:latest

USER root
RUN apt-get update && \
    apt-get install -y curl xz-utils gcc make libtinfo5 libgmp-dev zlib1g-dev

USER gitpod
RUN mkdir -p ~/.ghcup/bin && \
    curl https://gitlab.haskell.org/haskell/ghcup/raw/master/ghcup > ~/.ghcup/bin/ghcup && \
    chmod +x ~/.ghcup/bin/ghcup
ENV PATH="/home/gitpod/.cabal/bin:/home/gitpod/.ghcup/bin:${PATH}"
# ghcup upgrade is run twice (get a Haskell-rewrite version, get the recommended version from that)
RUN ghcup upgrade && \
    ghcup upgrade && \
    ghcup install ghc && \
    ghcup install cabal && \
    ghcup install stack && \
    ghcup install hls && \
    stack config set install-ghc false --global && \
    stack config set system-ghc  true  --global
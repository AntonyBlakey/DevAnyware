FROM devanyware/builds/base

COPY --from=devanyware/builds/llvm /llvm /llvm
RUN cat /llvm/zshenv >> /etc/zsh/zshenv

COPY resources /

ADD https://AntonyBlakey:bf8fbaf256b302a7be6582002b54bae08b75cf0d@api.github.com/repos/AntonyBlakey/xchainkeys/tarball src.tar.gz
RUN    /xchainkeys/0-install-dependencies.sh \
    && /xchainkeys/1-compile.sh
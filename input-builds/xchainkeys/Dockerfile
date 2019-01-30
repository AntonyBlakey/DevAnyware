FROM devanyware/builds/base

COPY --from=devanyware/builds/llvm /llvm /llvm
RUN cat /llvm/zshenv >> /etc/zsh/zshenv

COPY resources /

ADD https://api.github.com/repos/AntonyBlakey/xchainkeys/tarball src.tar.gz
RUN    /xchainkeys/0-install-dependencies.sh \
    && /xchainkeys/1-compile.sh
FROM devanyware/builds/base

COPY --from=devanyware/builds/llvm /llvm /llvm
RUN cat /llvm/zshenv >> /etc/zsh/zshenv

COPY resources /

RUN    /macos/0-install-dependencies.sh \
    && /macos/1-install-sdk.sh \
    && /macos/2-compile-cctools.sh 
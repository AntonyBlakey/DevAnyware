FROM devanyware/builds/base

COPY --from=devanyware/builds/llvm /llvm /llvm
RUN cat /llvm/zshenv >> /etc/zsh/zshenv

COPY --from=devanyware/builds/cmake /cmake /cmake
RUN cat /cmake/zshenv >> /etc/zsh/zshenv

COPY resources /

RUN    /polybar/0-install-dependencies.sh \
    && /polybar/1-compile.sh
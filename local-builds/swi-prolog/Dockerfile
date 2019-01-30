FROM devanyware/builds/base

COPY --from=devanyware/builds/llvm /llvm /llvm
RUN cat /llvm/zshenv >> /etc/zsh/zshenv

COPY --from=devanyware/builds/cmake /cmake /cmake
RUN cat /cmake/zshenv >> /etc/zsh/zshenv

COPY resources /

RUN    /swipl/0-install-dependencies.sh \ 
    && /swipl/1-compile.sh \ 
    && /swipl/2-install-plugins.sh
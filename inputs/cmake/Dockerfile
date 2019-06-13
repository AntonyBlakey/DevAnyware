FROM devanyware/builds/base

COPY --from=devanyware/builds/llvm /llvm /llvm
RUN cat /llvm/zshenv >> /etc/zsh/zshenv

COPY resources /

ADD https://codeload.github.com/Kitware/CMake/tar.gz/release release.tar.gz
RUN    /cmake/0-install-dependencies.sh \
    && /cmake/1-compile.sh
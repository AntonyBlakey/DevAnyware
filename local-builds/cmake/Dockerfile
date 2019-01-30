FROM devanyware/builds/base

COPY --from=devanyware/builds/llvm /llvm /llvm
RUN cat /llvm/zshenv >> /etc/zsh/zshenv

COPY resources /

ADD https://AntonyBlakey:bf8fbaf256b302a7be6582002b54bae08b75cf0d@codeload.github.com/Kitware/CMake/tar.gz/release release.tar.gz
RUN    /cmake/0-install-dependencies.sh \
    && /cmake/1-compile.sh
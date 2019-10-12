FROM devanyware/builds/base

COPY --from=devanyware/builds/llvm /llvm /llvm
RUN cat /llvm/zshenv >> /etc/zsh/zshenv

COPY resources /

# https://github.com/Kitware/CMake/releases
ENV CMAKE_VERSION=3.15.4
ADD https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz release.tar.gz
RUN    /cmake/0-install-dependencies.sh \
    && /cmake/1-compile.sh
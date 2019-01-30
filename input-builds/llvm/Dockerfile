FROM devanyware/builds/base

COPY resources /

# ADD https://github.com/llvm-mirror/llvm/archive/master.tar.gz llvm-master.tar.gz
# ADD https://github.com/llvm-mirror/clang/archive/master.tar.gz clang-master.tar.gz
# ADD https://github.com/llvm-mirror/lld/archive/master.tar.gz lld-master.tar.gz
RUN    /llvm/0-install-dependencies.sh \ 
    && /llvm/1-compile.sh
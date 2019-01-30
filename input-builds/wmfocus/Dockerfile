FROM devanyware/builds/base

COPY --from=devanyware/builds/llvm /llvm /llvm
RUN cat /llvm/zshenv >> /etc/zsh/zshenv

COPY resources /

ADD https://api.github.com/repos/svenstaro/wmfocus/tarball wmfocus.tar.gz
RUN    /wmfocus/0-install-dependencies.sh \
    && /wmfocus/1-compile.sh
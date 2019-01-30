FROM devanyware/builds/base

COPY resources /

RUN    /windows/0-create-binary-links.sh \
    && /windows/1-install-sdks.sh \
    && /windows/2-fix-filename-case.sh
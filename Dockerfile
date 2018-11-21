FROM frolvlad/alpine-glibc

LABEL maintainer "mandaiy <mandai.yusaku@gmail.com>"

ARG VERSION="2018"

ENV PATH /usr/local/texlive/2018/bin/x86_64-linux:$PATH

RUN mkdir /tmp/install-tl-unx
COPY texlive.profile /tmp/install-tl-unx

SHELL [ "/bin/sh", "-o", "pipefail", "-c" ]
RUN apk --no-cache add perl bash wget fontconfig-dev freetype-dev \
                       git mercurial subversion && \
    wget -qO - https://texlive.texjp.org/${VERSION}/tlnet/install-tl-unx.tar.gz | \
    tar -xz -C /tmp/install-tl-unx --strip-components=1

RUN /tmp/install-tl-unx/install-tl \
      --profile=/tmp/install-tl-unx/texlive.profile \
      --repository=http://texlive.texjp.org/${VERSION}/tlnet

RUN rm -rf /tmp/install-tl-unx

RUN mkdir /workdir
WORKDIR /workdir
VOLUME /workdir

CMD [ "bash" ]

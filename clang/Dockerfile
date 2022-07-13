ARG DEBIAN_VERSION="bullseye"
ARG CMAKE_VERSION="3.22.5"
FROM invasy/remote-dev-cpp:${CMAKE_VERSION}-${DEBIAN_VERSION}
LABEL maintainer="Vasiliy Polyakov <docker@invasy.dev>"

ARG DEBIAN_VERSION="bullseye"
ARG CLANG_VERSION="14"

# Install clang and clangd
RUN set -eux; \
  echo "deb http://apt.llvm.org/${DEBIAN_VERSION}/ llvm-toolchain-${DEBIAN_VERSION}-${CLANG_VERSION} main" >/etc/apt/sources.list.d/llvm.list; \
  wget --quiet --output-document=- 'https://apt.llvm.org/llvm-snapshot.gpg.key' | apt-key add - >/dev/null; \
  apt-get update -q; apt-get install -qy --no-install-recommends \
    clang-${CLANG_VERSION} \
    clang-format-${CLANG_VERSION} \
    clang-tidy-${CLANG_VERSION} \
    clang-tools-${CLANG_VERSION} \
    clangd-${CLANG_VERSION} \
    lld-${CLANG_VERSION} \
    lldb-${CLANG_VERSION}; \
  rm -rf /var/lib/apt/lists/* /var/cache/* /var/log/* /tmp/* /root/.gnupg

# Setup environment
RUN set -eux; \
  mkdir -p ~builder/.ssh; (\
    echo "CC=/usr/bin/clang-${CLANG_VERSION}"; \
    echo "CXX=/usr/bin/clang++-${CLANG_VERSION}"; \
  ) >>~builder/.ssh/environment; \
  chown -R builder: ~builder/.ssh; chmod -R go= ~builder/.ssh
ENV CC="/usr/bin/clang-${CLANG_VERSION}" CXX="/usr/bin/clang++-${CLANG_VERSION}"

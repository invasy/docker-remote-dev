ARG DEBIAN_VERSION="bullseye"
FROM debian:${DEBIAN_VERSION}-slim
LABEL maintainer="Vasiliy Polyakov <docker@invasy.dev>"

# Update package info, install dependencies, apply config, clean up
RUN set -eux; \
  export DEBIAN_FRONTEND=noninteractive; \
  apt-get update -q; apt-get upgrade -qy; \
  apt-get install -qy --no-install-recommends \
    ca-certificates \
    gnupg \
    openssh-server \
    rsync \
    unzip \
    wget \
  ; \
  echo 'kernel.perf_event_paranoid=1' > /etc/sysctl.d/99-perf.conf; \
  rm -rf /var/lib/apt/lists/* /var/cache/* /var/log/* /tmp/* /root/.gnupg
COPY sshd_config /etc/ssh/sshd_config

# Create user
RUN set -eux; \
  useradd --user-group --create-home --comment='Remote Builder' --shell=/bin/bash builder; \
  yes builder | passwd --quiet builder; touch ~builder/.hushlogin; \
  mkdir -p ~builder/.ssh; touch ~builder/.ssh/environment; \
  chown -R builder: ~builder; chmod -R go= ~builder

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-e"]

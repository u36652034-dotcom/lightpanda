FROM debian:stable-slim
RUN apt-get update -yq && \
    apt-get install -yq --no-install-recommends curl ca-certificates tini && \
    rm -rf /var/lib/apt/lists/*
RUN curl --fail -L --retry 3 -o /bin/lightpanda \
    https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-linux && \
    chmod +x /bin/lightpanda
EXPOSE 9222
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["sh", "-c", "/bin/lightpanda serve --host 0.0.0.0 --port ${PORT:-9222} --advertise-host lightpanda-905n.onrender.com --log-level info"]

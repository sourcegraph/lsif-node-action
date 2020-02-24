FROM node:13.3.0-alpine3.10 as builder

# The commit at which to build lsif-npm and lsif-tsc
ENV INDEXER_COMMIT=711ad719a2d66d946be7dd4e6a322b3716d29d62
ENV CLONE_URL="https://github.com/sourcegraph/lsif-node.git"

RUN apk add --no-cache git=2.22.2-r0

WORKDIR /build
RUN git clone "${CLONE_URL}" . && \
    git checkout -q "${INDEXER_COMMIT}" && \
    npm install typescript@3.5.x

# We build only the necessary parts here (tsc and npm projects).
# Both of our targets have a dependency on the protocol, so we 
# need to build that as well.
#
# Normally, you'd want to just follow the package.json setup, but
# the postinstall hook fails in the docker context for some reason.

WORKDIR /build/protocol
RUN npm install && npm run compile
WORKDIR /build/tsc
RUN npm install && npm run compile
WORKDIR /build/npm
RUN npm install && npm run compile 

FROM node:13.3.0-alpine3.10

LABEL version="0.1.0"
LABEL repository="http://github.com/sourcegraph/lsif-node-action"
LABEL homepage="http://github.com/sourcegraph/lsif-node-action"
LABEL maintainer="Sourcegraph Support <support@sourcegraph.com>"

LABEL "com.github.actions.name"="Sourcegraph Node LSIF Indexer"
LABEL "com.github.actions.description"="Generate LSIF data from TypeScript source code"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="purple"

COPY --from=builder /build /lsif-node
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

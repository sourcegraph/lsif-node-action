FROM node:13.3.0-alpine3.10

ENV INDEXER_VERSION=0.5.4

RUN apk add --no-cache \
    # Needed by the indexer to populate defaults
    git=2.22.2-r0

LABEL version="0.1.0"
LABEL repository="http://github.com/sourcegraph/lsif-node-action"
LABEL homepage="http://github.com/sourcegraph/lsif-node-action"
LABEL maintainer="Sourcegraph Support <support@sourcegraph.com>"

LABEL "com.github.actions.name"="Sourcegraph Node LSIF Indexer"
LABEL "com.github.actions.description"="Generate LSIF data from TypeScript source code"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="purple"

RUN npm install -g "@sourcegraph/lsif-tsc@${INDEXER_VERSION}"
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

FROM onyxlanguage/onyx:nightly-ovm-alpine AS build

RUN apk add git

WORKDIR /app

COPY onyx-pkg.kdl onyx-pkg.kdl
RUN onyx pkg sync

COPY src src
COPY build.onyx build.onyx
RUN onyx pkg build default

FROM onyxlanguage/onyx:nightly-ovm-alpine

WORKDIR /app

COPY www www
COPY --from=build /app/out.wasm /app/out.wasm

ENV SERVER_PORT=8080
EXPOSE 8080

CMD ["onyx", "run", "out.wasm"]


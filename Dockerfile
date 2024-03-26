FROM onyx:latest

RUN apt install --yes git

WORKDIR /app

COPY onyx-pkg.kdl onyx-pkg.kdl
RUN onyx pkg sync

COPY src src
COPY build.onyx build.onyx
RUN onyx pkg build default
RUN rm -r src

COPY www www

ENV SERVER_PORT 8080
EXPOSE 8080

CMD onyx run out.wasm


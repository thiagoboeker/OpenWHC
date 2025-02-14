FROM bitwalker/alpine-elixir-phoenix:latest AS phx-builder

WORKDIR /app

RUN apk update && apk add bash

# Install Hex + Rebar
RUN mix do local.hex --force, local.rebar --force

COPY config/ /app/config/
COPY mix.exs /app/
COPY mix.* /app/

ENV SECRET_KEY_BASE "${SECRET_KEY_BASE}"

COPY . /app/

RUN cd assets && \
    npm install

ENV MIX_ENV=prod
RUN mix do deps.get --only $MIX_ENV, deps.compile, phx.digest

WORKDIR /app
RUN MIX_ENV=prod mix release

########################################################################

FROM bitwalker/alpine-elixir-phoenix:latest


ENV MIX_ENV=prod \
    SHELL=/bin/bash

RUN apk add --update openssl ncurses-libs \
    rm -rf /var/cache/apk/*

WORKDIR /app
COPY --from=phx-builder /app/_build/prod/rel/open_whc .

CMD ["./bin/open_whc", "start"]
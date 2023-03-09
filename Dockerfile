FROM mvkvc/pinkie:latest

ENV MIX_ENV=dev

RUN mix deps.get --only dev
RUN mix compile

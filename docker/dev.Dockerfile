FROM mvkvc/pinkie:latest

ENV MIX_ENV=dev

RUN mix deps.get
RUN mix compile

CMD [ "mix phx.server" ]

#!/bin/bash

export MIX_ENV=test

mix test
mix dialyzer
mix format
mix credo --strict
mix meandro --files lib/**/*.ex
mix hex.audit
mix deps.audit
mix sobelow

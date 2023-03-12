defmodule Pinkie.BaseWallaby do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  feature "wallaby starts", %{session: session} do
    session
    |> visit("/")
    |> take_screenshot(name: "default")
    |> click(Query.button("toggle-darkmode"))
    |> take_screenshot(name: "toggle")
  end
end

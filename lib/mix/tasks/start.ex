defmodule Mix.Tasks.Start do
  use Mix.Task

  def run(_) do
    tasks = [
      Task.async(fn -> Mix.Task.run("tailwind.watch") end),
      Task.async(fn -> Mix.Task.run("phx.server") end)
    ]

    Enum.map(tasks, &Task.await(&1, :infinity))
  end
end

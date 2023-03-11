defmodule Pinkie.MixProject do
  use Mix.Project

  @description "Pinkie is a self-hostable remote pinning service for IPFS."
  @source_url "https://github.com/mvkvc/pinkie"
  @version "0.1.0"

  def project do
    [
      app: :pinkie,
      description: @description,
      version: @version,
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      dialyzer: dialyzer(),
      aliases: aliases(),
      test_coverage: [tool: ExCoveralls]
    ]
  end

  def application do
    [
      mod: {Pinkie.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp docs do
    [
      extras:
        [
          {:"README.md", [title: "Overview"]},
          Enum.map(File.ls!("docs/"), fn file -> "docs/#{file}" end),
          "LICENSE.md"
        ]
        |> List.flatten(),
      main: "readme",
      assets: "assets",
      logo: "assets/images/logo.png",
      source_url: @source_url,
      source_ref: "v#{@version}"
    ]
  end

  defp dialyzer do
    [
      plt_core_path: "priv/plts",
      plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
    ]
  end

  defp deps do
    [
      {:kubo_ex, path: "../kubo_ex"},
      # {:kubo_ex, git: "https://github.com/mvkvc/kubo_ex.git"},
      {:bcrypt_elixir, "~> 3.0"},
      {:phoenix, "~> 1.6.15"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.6"},
      {:ecto_sqlite3, ">= 0.0.0"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.17.5"},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:esbuild, "~> 0.4", runtime: Mix.env() == :dev},
      {:swoosh, "~> 1.3"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.18"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      {:flame_on, "~> 0.5.2", only: :dev},
      {:excoveralls, "~> 0.10", only: [:dev, :test], runtime: false},
      {:sobelow, "~> 0.11", only: [:dev, :test], runtime: false},
      {:mix_audit, "~> 2.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:meandro, "~> 0.1.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      setup: ["cmd npm install", "deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.deploy": ["tailwind.minify", "esbuild default --minify", "phx.digest"],
      docs: ["docs --formatter html"],
      tailwind: ["cmd npm run tailwind"],
      "tailwind.watch": ["cmd npm run tailwind:watch"],
      "tailwind.minify": ["cmd npm run tailwind:minify"]
    ]
  end
end

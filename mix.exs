defmodule Invest.Manager.MixProject do
  use Mix.Project

  def project do
    [
      app: :manager,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rop, git: "https://github.com/ryantaylor/rop.git", branch: "master"},
      {:invest_persistence, git: "https://github.com/investex/invest_persistence.git", branch: "master"},
      {:utils, git: "https://github.com/investex/utils.git", branch: "master"},
      {:ex_machina, "~> 2.3", only: [:test, :dev]},
      {:faker, "~> 0.13", only: [:test, :dev]}
    ]
  end

  # This makes sure your factory and any other modules in test/support are compiled
  # when in the test environment.
  defp elixirc_paths(env) when env in [:dev, :test],
    do: [
      "lib",
      "test/support",
      "test/factories",
      "deps/invest_persistence/test/support",
      "deps/invest_persistence/test/factories"
    ]

  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end

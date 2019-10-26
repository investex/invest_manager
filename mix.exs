defmodule Manager.MixProject do
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
      {:rop, git: "https://github.com/ryantaylor/rop.git"},
      {:persistence, path: "/Users/ryantaylor/Code/invest/persistence"},
      {:utils, path: "/Users/ryantaylor/Code/invest/utils"},
      {:ex_machina, "~> 2.3", only: [:test, :dev]},
      {:faker, "~> 0.13", only: [:test, :dev]}
    ]
  end

  # This makes sure your factory and any other modules in test/support are compiled
  # when in the test environment.
  defp elixirc_paths(:test), do: ["lib", "test/support", "test/factories", "/Users/ryantaylor/Code/invest/persistence/test/support", "/Users/ryantaylor/Code/invest/persistence/test/factories"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end

defmodule SpearExperiment.MixProject do
  use Mix.Project

  def project do
    [
      app: :spear_experiment,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {SpearExperiment.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:spear, "~> 1.3"},
      {:jason, "~> 1.4"}
    ]
  end
end

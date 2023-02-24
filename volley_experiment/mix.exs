defmodule VolleyExperiment.MixProject do
  use Mix.Project

  def project do
    [
      app: :volley_experiment,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {VolleyExperiment.Application, []}
    ]
  end

  defp deps do
    [
      {:volley, "~> 1.0"},
      {:broadway, "~> 1.0"},
      {:jason, "~> 1.4"}
    ]
  end
end

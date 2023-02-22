import Config

host = System.get_env("EVENTSTORE_HOST") || "localhost"

config :spear_experiment, SpearExperiment.Client,
  connection_string: "esdb://admin:changeit@#{host}:2113"

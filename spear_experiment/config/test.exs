import Config

host = System.get_env("EVENTSTORE_HOST") || "localhost"

config :spear_experiment, Spear.Test.ClientFixture, connection_string: "esdb://localhost:2113"

config :spear_experiment, SpearExperiment.Client,
  connection_string: "esdb://admin:changeit@#{host}:2113"

defmodule KafkaExperimentTest do
  use ExUnit.Case
  doctest KafkaExperiment

  test "greets the world" do
    assert KafkaExperiment.hello() == :world
  end
end

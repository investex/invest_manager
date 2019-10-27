defmodule Invest.ManagerTest do
  use ExUnit.Case
  doctest Manager

  test "greets the world" do
    assert Invest.Manager.hello() == :world
  end
end

defmodule Invest.Manager.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Invest.Persistence.Repo

      import Ecto
      import Ecto.Query
      import Invest.Manager.RepoCase

      # and any other stuff
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Invest.Persistence.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Invest.Persistence.Repo, {:shared, self()})
    end

    :ok
  end
end

defmodule Manager do
  defdelegate create_portfolio(params), to: Manager.Sagas.CreatePortfolio, as: :process
end

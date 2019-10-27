defmodule Invest.Manager do
  defdelegate create_portfolio(params), to: Invest.Manager.Sagas.CreatePortfolio, as: :process
end

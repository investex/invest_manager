defmodule Manager.Sagas.CreatePortfolio do
  use Rop

  import Utils.Rop

  alias Manager.Forms.CreatePortfolioForm
  alias Persistence.{Portfolio, Repo}

  def process(%{portfolio: _, current_user: _} = params) do
    params
    |> attach_to_user
    >>> CreatePortfolioForm.validate_input
    >>> insert_record
  end

  defp attach_to_user(%{current_user: nil}) do
    err("Must be logged in to perform this action")
  end

  defp attach_to_user(%{current_user: %{id: id}} = params) do
    params
    |> put_in([:portfolio, :user_id], id)
    |> ok
  end

  defp insert_record(%{portfolio: portfolio} = params) do
    %Portfolio{}
    |> Portfolio.changeset(portfolio)
    |> Repo.insert
    >>> put_back(params, :portfolio)
  end
end

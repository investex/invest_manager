defmodule Invest.Manager.Sagas.CreateAccount do
  use Rop

  import Utils.Rop

  alias Invest.Manager.Forms.CreateAccountForm
  alias Invest.Persistence.{Account, Portfolio, Repo, User}

  def process(%{account: _, current_user: _} = params) do
    params
    >>> CreateAccountForm.validate_input
    >>> errorTee(authorize)
    >>> insert_record
  end

  defp authorize(%{current_user: nil}) do
    err("Must be logged in to perform this action")
  end

  defp authorize(%{account: %{portfolio_id: portfolio_id}, current_user: user}) do
    Portfolio
    |> Repo.fetch(portfolio_id)
    >>> authorize_for_update(user)
  end

  defp authorize_for_update(%Portfolio{} = portfolio, %User{} = user) do
    if portfolio.user_id == user.id do
      {:ok, portfolio}
    else
      {:error, "You are not authorized to perform that action."}
    end
  end

  defp insert_record(%{account: account} = params) do
    %Account{}
    |> Account.changeset(account)
    |> Repo.insert
    >>> put_back(params, :account)
  end
end

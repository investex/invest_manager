defmodule Manager.Forms.CreatePortfolioForm do
  use Ecto.Schema
  use Rop

  import Ecto.Changeset
  import Utils.Rop

  embedded_schema do
    field :user_id
    field :currency
  end

  def changeset(form, params \\ %{}) do
    form
    |> cast(params, [:user_id, :currency])
    |> validate_required([:user_id, :currency])
  end

  def validate_input(%{portfolio: portfolio} = params) do
    %__MODULE__{}
    |> __MODULE__.changeset(portfolio)
    |> apply_action(:insert)
    >>> bind(Map.from_struct)
    >>> put_back(params, :portfolio)
  end
end

defmodule Manager.Forms.CreatePortfolioForm do
  use Ecto.Schema
  use Rop

  import Ecto.Changeset
  import Utils.Rop

  embedded_schema do
    field :user_id, :id
    field :currency, :string
    field :name, :string
  end

  def changeset(form, params \\ %{}) do
    form
    |> cast(params, [:user_id, :currency, :name])
    |> validate_required([:user_id, :currency, :name])
  end

  def validate_input(%{portfolio: portfolio} = params) do
    %__MODULE__{}
    |> __MODULE__.changeset(portfolio)
    |> apply_action(:insert)
    >>> bind(Map.from_struct)
    >>> put_back(params, :portfolio)
  end
end

defmodule Manager.Forms.CreateAccountForm do
  use Ecto.Schema
  use Rop

  import Ecto.Changeset
  import Utils.Rop

  @designations [
    "tfsa",
    "rrsp",
    "resp",
    "lira",
    "rrif",
    "unregistered"
  ]

  embedded_schema do
    field :portfolio_id, :id
    field :designation, :string
    field :tax_discount, :decimal
  end

  def changeset(form, params \\ %{}) do
    form
    |> cast(params, [:portfolio_id, :designation, :tax_discount])
    |> validate_required([:portfolio_id, :designation, :tax_discount])
    |> validate_inclusion(:designation, @designations)
    |> validate_number(:tax_discount, greater_than_or_equal_to: 0, less_than_or_equal_to: 1)
  end

  def validate_input(%{account: account} = params) do
    %__MODULE__{}
    |> __MODULE__.changeset(account)
    |> apply_action(:insert)
    >>> bind(Map.from_struct)
    >>> put_back(params, :account)
  end
end

defmodule TodoLiveView.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :status, :string
    field :title, :string
    field :desc, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :desc, :status])
    |> validate_required([:title, :desc, :status])
  end
end

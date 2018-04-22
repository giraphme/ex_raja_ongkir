defmodule ExRajaOngkir.Province do
  alias ExRajaOngkir.Request
  defstruct [:id, :name]

  def get!(id \\ nil) do
    {:ok, result} = get(id)
    result
  end

  def get(id \\ nil)

  def get(nil) do
    "province"
    |> Request.get()
    |> Request.cast_to(__MODULE__)
  end

  def get(id) do
    "province?id=#{id}"
    |> Request.get()
    |> Request.cast_to(__MODULE__)
  end

  @behaviour ExRajaOngkir.Model
  def scheme do
    %{id: "province_id", name: "province"}
  end
end

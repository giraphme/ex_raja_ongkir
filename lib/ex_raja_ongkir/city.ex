defmodule ExRajaOngkir.City do
  alias ExRajaOngkir.Request
  defstruct [:id, :name, :province_id, :province_name, :type, :postal_code]

  def get!(id \\ nil) do
    {:ok, result} = get(id)
    result
  end

  def get(id \\ nil)

  def get(nil) do
    "city"
    |> Request.get()
    |> Request.cast_to(__MODULE__)
  end

  def get(id) do
    "city?id=#{id}"
    |> Request.get()
    |> Request.cast_to(__MODULE__)
  end

  @behaviour ExRajaOngkir.Model
  def scheme do
    %{
      id: "city_id",
      name: "city_name",
      province_id: "province_id",
      province_name: "province",
      type: "type",
      postal_code: "postal_code"
    }
  end
end

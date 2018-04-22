defmodule ExRajaOngkir.Estimate do
  defstruct [:etd, :price, :currency, :note]

  def cast_from_response(response) do
    response
    |> Enum.map(fn estimate ->
      %__MODULE__{
        etd: estimate[:etd],
        price: estimate[:value],
        # TODO
        currency: "IDR",
        note: estimate[:note]
      }
    end)
  end
end

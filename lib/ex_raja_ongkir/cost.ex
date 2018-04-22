defmodule ExRajaOngkir.Cost do
  alias ExRajaOngkir.Request

  defstruct [
    :from,
    :to,
    :weight,
    :weight_unit,
    :courier_code,
    :courier_name,
    :description,
    :service_name,
    :estimates
  ]

  def calculate!(from, to, weight, courier) do
    {:ok, result} = calculate(from, to, weight, courier)
    result
  end

  def calculate(from, to, weight, courier) when is_list(courier) do
    calculate(from, to, weight, Enum.join(courier, ":"))
  end

  def calculate(%{id: from_id} = from, %{id: to_id} = to, weight, courier)
      when is_integer(weight) and is_binary(courier) do
    params = %{origin: from_id, destination: to_id, weight: weight, courier: courier}

    Request.post(
      "cost",
      headers: ["Content-Type": "application/x-www-form-urlencoded"],
      body:
        params
        |> Enum.map(fn {key, value} -> "#{key}=#{value}" end)
        |> Enum.join("&")
    )
    |> Request.take_result()
    |> case do
      {:ok, results} -> {:ok, parse_to_self(from, to, weight, results)}
      {:error, reason} -> {:error, reason}
    end
  end

  defp parse_to_self(from, to, weight, results) do
    results
    |> Enum.map(fn result ->
      base_struct = %__MODULE__{
        from: from,
        to: to,
        weight: weight,
        # TODO
        weight_unit: 'g',
        courier_code: result["code"],
        courier_name: result["name"]
      }

      {
        base_struct.courier_code |> String.to_atom(),
        Enum.map(result["costs"], fn cost ->
          %{
            base_struct
            | description: cost["description"],
              service_name: cost["service"],
              estimates: ExRajaOngkir.Estimate.cast_from_response(cost["cost"])
          }
        end)
      }
    end)
    |> Enum.into(%{})
  end
end

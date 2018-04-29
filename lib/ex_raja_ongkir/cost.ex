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
    :estimates,
    :params
  ]

  def calculate!(from, to, weight, courier, opts \\ []) do
    {:ok, result} = calculate(from, to, weight, courier, opts)
    result
  end

  def calculate(from, to, weight, courier, opts \\ [])

  def calculate(from, to, weight, courier, opts) when is_list(courier) do
    calculate(from, to, weight, Enum.join(courier, ":"), opts)
  end

  def calculate(from, to, weight, courier, opts)
      when is_integer(weight) and is_binary(courier) do
    struct = make_struct(from, to, weight, courier, opts)

    response =
      struct
      |> make_params()
      |> request()
      |> Request.take_result()

    response
    |> case do
      {:ok, results} -> {:ok, response_into(results, struct)}
      {:error, reason} -> {:error, reason}
    end
  end

  defp make_struct(from, to, weight, courier, opts) do
    %__MODULE__{
      params: %{
        origin: from,
        destination: to,
        weight: weight,
        courier: courier,
        opts: opts
      }
    }
  end

  defp make_params(%__MODULE__{params: params}) do
    make_params_by_plan(
      ExRajaOngkir.plan(),
      params
    )
  end

  defp make_params_by_plan(:starter, %{
         origin: %{id: origin_id},
         destination: %{id: destination_id},
         weight: weight,
         courier: courier
       }) do
    %{origin: origin_id, destination: destination_id, weight: weight, courier: courier}
  end

  defp make_params_by_plan(:basic, params) do
    make_params_by_plan(:starter, params)
  end

  @defult_origin_type 'city'
  @defult_destination_type 'city'
  defp make_params_by_plan(:pro, %{opts: opts} = params) do
    Map.merge(make_params_by_plan(:basic, params), %{
      originType: opts[:origin_type] || @defult_origin_type,
      destinationType: opts[:destination_type] || @defult_destination_type
    })
  end

  defp request(params) do
    Request.post(
      "cost",
      headers: ["Content-Type": "application/x-www-form-urlencoded"],
      body:
        params
        |> Enum.map(fn {key, value} -> "#{key}=#{value}" end)
        |> Enum.join("&")
    )
  end

  defp response_into(response, %__MODULE__{params: params} = struct) do
    response
    |> Enum.map(fn row ->
      base_struct = %{
        struct
        | from: params[:from],
          to: params[:destination],
          weight: params[:weight],
          weight_unit: 'g',
          courier_code: row["code"],
          courier_name: row["name"]
      }

      {
        base_struct.courier_code |> String.to_atom(),
        Enum.map(row["costs"], fn cost ->
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

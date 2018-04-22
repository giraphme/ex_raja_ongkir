defmodule ExRajaOngkir.Request do
  use HTTPotion.Base

  def process_url(url) do
    ExRajaOngkir.base_url() <> url
  end

  def process_request_headers(headers) do
    headers
    |> Keyword.put(:"Content-Type", "application/json")
    |> Keyword.put(:key, ExRajaOngkir.api_key())
  end

  def process_response_body(body) do
    body |> Jason.decode!()
  end

  def cast_to(response, module) do
    response
    |> take_result()
    |> case do
      {:ok, result} -> {:ok, into(result, module)}
      {:error, reason} -> {:error, reason}
    end
  end

  def take_result(%HTTPotion.Response{
        body: %{"rajaongkir" => %{"results" => result, "status" => %{"code" => 200}}}
      }) do
    {:ok, result}
  end

  def take_result(%{
        body: %{"rajaongkir" => %{"status" => %{"code" => code, "description" => description}}}
      }) do
    {:error, "#{description} (#{code})"}
  end

  def take_result(_) do
    {:error, "Request failure"}
  end

  def into(result, module) when is_list(result) do
    Enum.map(result, &into(&1, module))
  end

  def into(result, module) when is_map(result) do
    struct(
      module,
      module.scheme
      |> Enum.map(fn {key, result_key} -> {key, result[result_key]} end)
      |> Enum.into(%{})
    )
  end
end

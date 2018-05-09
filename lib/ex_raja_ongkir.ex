defmodule ExRajaOngkir do
  @default_api_key {:system, "RAJA_ONGKIR_API_KEY"}
  def api_key do
    (Application.get_env(:ex_raja_ongkir, :api_key, nil) || @default_api_key)
    |> case do
      {:system, env_name} when is_binary(env_name) ->
        System.get_env(env_name)

      api_key when is_binary(api_key) ->
        api_key

      _ ->
        raise ExRajaOngkir.Exception.NoApiKey
    end
  end

  @default_plan :starter
  def plan do
    Application.get_env(:ex_raja_ongkir, :plan, nil) || @default_plan
  end

  def base_url do
    plan()
    |> case do
      :starter ->
        "https://api.rajaongkir.com/starter/"

      :basic ->
        "https://api.rajaongkir.com/basic/"

      :pro ->
        "https://pro.rajaongkir.com/api/"

      plan ->
        raise ExRajaOngkir.Exception.UnsupportedPlan, plan
    end
  end
end

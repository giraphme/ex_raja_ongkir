defmodule ExRajaOngkir do
  def api_key do
    Application.get_env(:ex_raja_ongkir, :api_key, nil)
    |> case do
      {:system, env_name} when is_binary(env_name) ->
        System.get_env(env_name)

      api_key when is_binary(api_key) ->
        api_key

      _ ->
        raise ExRajaOngkir.Exception.NoApiKey
    end
  end
end

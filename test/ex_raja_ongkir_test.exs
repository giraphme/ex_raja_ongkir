defmodule ExRajaOngkirTest do
  use ExUnit.Case

  describe "ExRajaOngkir.api_key/0" do
    test "It can get the API key by raw string" do
      expected_api_key = "THIS_IS_API_KEY"
      Application.put_env(:ex_raja_ongkir, :api_key, expected_api_key)
      assert expected_api_key == ExRajaOngkir.api_key()
    end

    test "It can get the API key by system environment variable" do
      expected_api_key = "THIS_IS_API_KEY"
      env_name = "CHANGED_API_KEY_ENV_NAME"
      Application.put_env(:ex_raja_ongkir, :api_key, {:system, env_name})
      System.put_env(env_name, expected_api_key)
      assert expected_api_key == ExRajaOngkir.api_key()
    end

    test "It fail to get the API key because set invalid api_key" do
      expected_api_key = 1234
      Application.put_env(:ex_raja_ongkir, :api_key, expected_api_key)

      assert_raise(ExRajaOngkir.Exception.NoApiKey, fn ->
        ExRajaOngkir.api_key()
      end)
    end

    test "It fail to get the API key because didn't set" do
      Application.put_env(:ex_raja_ongkir, :api_key, nil)

      assert_raise(ExRajaOngkir.Exception.NoApiKey, fn ->
        ExRajaOngkir.api_key()
      end)
    end
  end
end

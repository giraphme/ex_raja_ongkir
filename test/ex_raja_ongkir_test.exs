defmodule ExRajaOngkirTest do
  use ExUnit.Case

  setup_all do
    default_api_key = Application.get_env(:ex_raja_ongkir, :api_key)
    default_plan = Application.get_env(:ex_raja_ongkir, :plan)

    on_exit(:name, fn ->
      Application.put_env(:ex_raja_ongkir, :api_key, default_api_key)
      Application.put_env(:ex_raja_ongkir, :plan, default_plan)
    end)

    :ok
  end

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
  end

  describe "ExRajaOngkir.base_url/0" do
    test "It can get URL string if the plan is :starter" do
      Application.put_env(:ex_raja_ongkir, :plan, :starter)
      assert Regex.match?(~r/^https?:\/\//, ExRajaOngkir.base_url())
    end

    test "It can get URL string if the plan is :basic" do
      Application.put_env(:ex_raja_ongkir, :plan, :basic)
      assert Regex.match?(~r/^https?:\/\//, ExRajaOngkir.base_url())
    end

    test "It can get URL string if the plan is :pro" do
      Application.put_env(:ex_raja_ongkir, :plan, :pro)
      assert Regex.match?(~r/^https?:\/\//, ExRajaOngkir.base_url())
    end

    test "It fail to get URL string because the plan is nosupported" do
      Application.put_env(:ex_raja_ongkir, :plan, :unknown)

      assert_raise(ExRajaOngkir.Exception.UnsupportedPlan, fn ->
        ExRajaOngkir.base_url()
      end)
    end
  end
end

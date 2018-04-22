defmodule ExRajaOngkir.RequestTest do
  use ExUnit.Case

  describe "ExRajaOngkir.Request.take_result/1" do
    test "It get the result from RajaOngkir response" do
      expected_result = "This is result"

      mock_response = %HTTPotion.Response{
        body: %{"rajaongkir" => %{"results" => expected_result, "status" => %{"code" => 200}}}
      }

      assert {:ok, expected_result} == ExRajaOngkir.Request.take_result(mock_response)
    end

    test "It fail to get the result because the request was failed" do
      expected_result = "This is result"

      mock_response = %HTTPotion.Response{
        body: %{"rajaongkir" => %{"results" => expected_result, "status" => %{"code" => 500}}}
      }

      assert {:error, _} = ExRajaOngkir.Request.take_result(mock_response)
    end
  end
end

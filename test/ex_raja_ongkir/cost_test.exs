defmodule ExRajaOngkir.CostTest do
  use ExUnit.Case

  describe "ExRajaOngkir.Cost.calculate/4" do
    # TODO
    # test "It return array of %City{}"

    test "It return %Cost{}" do
      city_1 = %ExRajaOngkir.City{id: "1"}
      city_2 = %ExRajaOngkir.City{id: "2"}
      weight = 17_000
      courier = "jne"

      assert {:ok, %{jne: [%ExRajaOngkir.Cost{}]}} =
               ExRajaOngkir.Cost.calculate(city_1, city_2, weight, courier)
    end
  end
end

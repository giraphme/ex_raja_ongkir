defmodule ExRajaOngkir.CityTest do
  use ExUnit.Case

  describe "ExRajaOngkir.City.get/1" do
    test "It return array of %City{}" do
      assert {:ok, cities} = ExRajaOngkir.City.get()
      city = List.first(cities)
      assert %ExRajaOngkir.City{} = city
    end

    test "It return %City{}" do
      assert {:ok, %ExRajaOngkir.City{}} = ExRajaOngkir.City.get(1)
    end
  end
end

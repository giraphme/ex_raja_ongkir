defmodule ExRajaOngkir.ProvinceTest do
  use ExUnit.Case

  describe "ExRajaOngkir.Province.get/1" do
    test "It return array of %Province{}" do
      assert {:ok, provinces} = ExRajaOngkir.Province.get()
      province = List.first(provinces)
      assert %ExRajaOngkir.Province{} = province
    end

    test "It return %Province{}" do
      assert {:ok, %ExRajaOngkir.Province{}} = ExRajaOngkir.Province.get(1)
    end
  end
end

defmodule ExRajaOngkir.CostTest do
  use ExUnit.Case

  describe "ExRajaOngkir.Cost.calculate/4" do
    @plans [
      starter: %{},
      basic: %{courier: ~w(jne tiki)},
      pro: %{courier: ~w(jne tiki)},
      pro: %{courier: ~w(jne tiki), origin_type: "city", destination_type: "city"}
    ]

    Enum.each(@plans, fn {plan, params} ->
      @plan plan
      @params params

      test "It return %Cost{} when plan is #{@plan} and the params is #{inspect(@params)}" do
        default_plan = Application.get_env(:ex_raja_ongkir, :plan)
        Application.put_env(:ex_raja_ongkir, :plan, @plan)

        from = @params[:from] || %ExRajaOngkir.City{id: "1"}
        to = @params[:to] || %ExRajaOngkir.City{id: "2"}
        weight = @params[:weight] || 17_000
        courier = @params[:courier] || "jne"
        opts = @params[:opts] || []

        assert {:ok, %{jne: [%ExRajaOngkir.Cost{}]}} =
                 ExRajaOngkir.Cost.calculate(from, to, weight, courier, opts)

        Application.put_env(:ex_raja_ongkir, :plan, default_plan)
      end
    end)
  end
end

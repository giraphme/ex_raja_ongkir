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

        assert {:ok, results} = ExRajaOngkir.Cost.calculate(from, to, weight, courier, opts)

        Enum.each(results, fn {provider, costs} ->
          assert provider
          assert is_atom(provider)
          assert is_list(costs)
          assert %ExRajaOngkir.Cost{} = cost = List.first(costs)
          assert is_binary(cost.courier_code)
          assert is_binary(cost.courier_name)
          assert is_binary(cost.description)
          assert is_list(cost.estimates)
          assert %ExRajaOngkir.Estimate{} = estimate = List.first(cost.estimates)
          assert is_binary(estimate.currency)
          assert is_binary(estimate.etd)
          assert is_integer(estimate.price)
          assert cost.params[:origin] == from
          assert cost.params[:destination] == to
          assert is_binary(cost.params[:courier])
          assert cost.params[:weight] == weight
          assert is_binary(cost.service_name)
          assert is_binary(cost.service_name)
        end)

        Application.put_env(:ex_raja_ongkir, :plan, default_plan)
      end
    end)

    test "It should return error if the weight is too small" do
      default_plan = Application.get_env(:ex_raja_ongkir, :plan)
      Application.put_env(:ex_raja_ongkir, :plan, :pro)

      assert {:error, _reason} =
               ExRajaOngkir.Cost.calculate(
                 %ExRajaOngkir.City{id: "1"},
                 %ExRajaOngkir.City{id: "2"},
                 0,
                 "jne",
                 []
               )

      Application.put_env(:ex_raja_ongkir, :plan, default_plan)
    end
  end
end

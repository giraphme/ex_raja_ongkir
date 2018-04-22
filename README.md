# ExRajaOngkir

Please refer to this documentation if you want to get more information.  
[https://hexdocs.pm/ex_raja_ongkir](https://hexdocs.pm/ex_raja_ongkir)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_raja_ongkir` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_raja_ongkir, "~> 0.1.0"}
  ]
end
```

## Configuration
If you want to change the default configuration, put the followings to your `mix.exs`.

```elixir
# You can set :starter or :basic or :pro
config :ex_raja_ongkir, :plan, :starter

# You can set raw API key
config :ex_raja_ongkir, :api_key, "THIS_IS_YOUR_API_KEY"

# It will load from environment variables
config :ex_raja_ongkir, :api_key, {:system, "CUSTOM_ENV_NAME"}
```

## Basic usage

```elixir
iex > province = ExRajaOngkir.Province.get!(1)
%ExRajaOngkir.Province{...}
iex > from_city = ExRajaOngkir.City.get!(1)
 %ExRajaOngkir.City{...}
iex > to_city = ExRajaOngkir.City.get!(2)
%ExRajaOngkir.City{...}
iex > weight = 17_000
iex > cost = ExRajaOngkir.Cost.calculate!(from_city, to_city, weight, "jne")
%{jne: [%ExRajaOngkir.Cost{...}]}
iex > costs = ExRajaOngkir.Cost.calculate!(from_city, to_city, weight, ~w(jne pos)) # It is able to use when higher than starter.
%{jne: [%ExRajaOngkir.Cost{...}], pos: [%ExRajaOngkir.Cost{...}]}
```

## License
This project is licensed under the terms of the MIT license, see LICENSE.

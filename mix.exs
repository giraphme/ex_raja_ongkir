defmodule ExRajaOngkir.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_raja_ongkir,
      version: "0.1.3",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: "API wrapper of RajaOngkir for Elixir.",
      package: [
        maintainers: ["Tamaki Maeda"],
        licenses: ["MIT"],
        links: %{
          "RajaOngkir" => "https://rajaongkir.com"
        }
      ],
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :httpotion]
    ]
  end

  defp deps do
    [
      {:power_assert, "~> 0.1.1", only: :test},
      {:httpotion, "~> 3.1.0"},
      {:jason, "~> 1.0"},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end
end

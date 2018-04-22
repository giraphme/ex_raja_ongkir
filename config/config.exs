use Mix.Config

# Set your contracting plan name.
# e.g. :starter, :basic, :pro
# Refert to https://rajaongkir.com/dokumentasi#daftar-kurir
config :ex_raja_ongkir, :plan, :starter

# You can set raw API key or {:system, ENV_NAME} tuple.
config :ex_raja_ongkir, :api_key, {:system, "RAJA_ONGKIR_API_KEY"}

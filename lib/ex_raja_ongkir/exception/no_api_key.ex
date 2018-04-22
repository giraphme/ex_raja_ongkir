defmodule ExRajaOngkir.Exception.NoApiKey do
  defexception(
    message:
      "API key is not set. Please refer to this documentation. (https://hexdocs.pm/ex_raja_ongkir)"
  )
end

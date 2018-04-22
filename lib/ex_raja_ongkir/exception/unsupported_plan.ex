defmodule ExRajaOngkir.Exception.UnsupportedPlan do
  defexception [:message]

  def exception(plan) do
    message =
      "`#{plan}` is not supported. Please refer to this documentation. (https://hexdocs.pm/ex_raja_ongkir)"

    %__MODULE__{message: message}
  end
end

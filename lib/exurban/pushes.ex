defmodule ExUrban.Pushes do
  alias ExUrban.Utils

  defmodule Push do
    defstruct audience: %{},
              notification: %{},
              device_types: []
  end

  def push(message) do
    Utils.query :post, 202, "push", message
  end
end

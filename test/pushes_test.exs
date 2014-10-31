defmodule ExUrbanTest.Pushes do
  use ExUnit.Case, async: true

  setup do
    Application.stop(:exurban)
    {:ok, _} = ExUrban.start

    push = %ExUrban.Pushes.Push{}
    {:ok, pushes: [push]}
  end

  test "can't send an empty message." do
    assert {:fail, _} = ExUrban.Pushes.push %{}
  end

  test "can't send an incomplete message.", %{pushes: [push]} do
    assert {:fail, _} = ExUrban.Pushes.push push
  end

  test "can send a proper formated message.", %{pushes: [push]} do
    push = %{push| audience: "all",
                   device_types: ["android"],
                   notification: %{android: %{extra: %{json: "test"}}}}
    assert {:ok, _} = ExUrban.Pushes.push push
  end
end

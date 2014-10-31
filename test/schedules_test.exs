defmodule ExUrbanTest.Schedules do
  use ExUnit.Case, async: true

  setup do
    Application.stop(:exurban)
    {:ok, _} = ExUrban.start

    schedule = %ExUrban.Schedules.Schedule{}
    push     = %ExUrban.Pushes.Push{}

    {:ok, schedules: [schedule], pushes: [push]}
  end

  test "can schedule a list of pushes", %{schedules: [s], pushes: [p]} do
    p = %{p| audience: "all",
             device_types: ["android"],
             notification: %{android: %{extra: %{json: "test"}}}}
    s = %{s| push: p, name: "Testing", schedule: %{scheduled_time: "2015-11-28 01:48:48"}}
    assert {:ok, _} = ExUrban.Schedules.schedule s
  end

  test "can list scheduled pushes" do
    assert {:ok, _} = ExUrban.Schedules.list
  end

  test "can update a scheduled action" do

  end

  test "can delete a scheduled action" do
    {:ok, resp} = ExUrban.Schedules.list
    Enum.map resp[:schedules], fn schedule ->
      {:ok, url} = Map.fetch(schedule, "url")
      %URI{path: path} = URI.parse url
      schedule_uri = List.last(String.split(path, "/"))
      assert {:ok, %{status: :deleted}} = ExUrban.Schedules.delete schedule_uri
    end
  end
end

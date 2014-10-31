defmodule ExUrban.Schedules do
  alias ExUrban.Utils

  defmodule Schedule do
    defstruct schedule: %{scheduled_time: ""},
              name: "",
              push: %ExUrban.Pushes.Push{}
  end

  def schedule(schedule) do
    Utils.query :post, 201, "schedules", schedule
  end

  def list do
    Utils.query :get, 200, "schedules"
  end

  def list(schedule) do
    Utils.query :get, 200, "schedules/#{schedule}"
  end

  def update(schedule, updated) do
    Utils.query :put, 200, "schedules/#{schedule}", updated
  end

  def delete(schedule) do
    Utils.query :delete, 204, "schedules/#{schedule}"
  end
end

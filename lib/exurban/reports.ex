defmodule ExUrban.Reports do
  alias ExUrban.Utils

  @doc """
  Returns a detailed report about an specific push notification.
  """
  def individual(push_id) do
    Utils.query :get, 200, "reports/responses/#{push_id}"
  end

  @doc """
  Returns a report based on installed and removed installations per device type.
  """
  def devices(date) do
    Utils.query :get, 200, "reports/devices/?date=#{date}"
  end

  @doc """
  Returns the number of pushes sent within a time period.
  """
  def sent_pushes(start_date, end_date, precision) do
    Utils.query :get, 200, "reports/sends/?start=#{start_date}&end=#{end_date}&precision=#{precision}"
  end

  @doc """
  Returns all the details for a specific push.
  """
  def per_push(push_id) do
    Utils.query :get, 200, "reports/perpush/detail/#{push_id}"
  end

  @doc """
  Returns the default time series data with an hourly precision of 12 hours.
  """
  def per_series(push_id) do
    Utils.query :get, 200, "reports/perpush/series/#{push_id}"
  end

  @doc """
  Returns the default time series data with an specific precision.
  """
  def per_series(push_id, precision) do
    Utils.query :get, 200, "reports/perpush/series/#{push_id}?precision=#{precision}"
  end

  @doc """
  Returns the default time series data with an specific precision and a start and end date.
  """
  def per_series(push_id, precision, start_date, end_date) do
    Utils.query :get, 200, "reports/perpush/series/#{push_id}?precision=#{precision}&start=#{start_date}&end=#{end_date}"
  end

  @doc """
  Returns the equivalent push ID for a message ID.
  """
  def get_send_id(message_id) do
    Utils.query :get, 200, "reports/mappings/send_ids/#{message_id}"
  end

end

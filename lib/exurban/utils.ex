defmodule ExUrban.Utils do
  use Jazz
  require Logger

  @timeout Application.get_env(:urban, :ua_timeout)

  def query(method, status, endpoint, object \\ %{}) do

    opts = [{:hackney, ExUrban.make_auth}, {:timeout, @timeout}]

    res = case method do
      :get    -> ExUrban.get endpoint, ExUrban.post_headers, opts
      :post   -> ExUrban.post endpoint, JSON.encode!(object), ExUrban.post_headers, opts
      :put    -> ExUrban.put endpoint, JSON.encode!(object), ExUrban.post_headers, opts
      :delete -> ExUrban.delete endpoint, ExUrban.post_headers, opts
    end

    case res do
      {:ok, %HTTPoison.Response{status_code: ^status, body: body}} -> {:ok, body}
      {:ok, %HTTPoison.Response{status_code: status, body: body}}  ->
        Logger.error(" (1) ++++++++++++++++++++++++++++++ ")
        IO.inspect body
        IO.inspect status
        Logger.error(" (1) ++++++++++++++++++++++++++++++ ")
        {:fail, body}
      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error(" (2) ++++++++++++++++++++++++++++++ ")
        IO.inspect reason
        Logger.error(" (2) ++++++++++++++++++++++++++++++ ")
        {:fail, [error: reason]}
    end

  end

end

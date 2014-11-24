defmodule ExUrban.Utils do
  require Logger
  use Jazz

  @timeout Application.get_env(:urban, :ua_timeout)

  def query(method, status, endpoint, object \\ %{}) do
    opts = [{:hackney, ExUrban.make_auth}, {:timeout, @timeout}]

    # TODO: delete this logger
    Logger.error("--------------------------------------------------------------")
    Logger.error("endpoint : #{endpoint}")
    Logger.error("headers  : #{ExUrban.post_headers}")
    Logger.error("opts     : #{opts}")
    Logger.error("message  : #{JSON.encode!(object)}")
    Logger.error("--------------------------------------------------------------")

    res = case method do
      :get    -> ExUrban.get endpoint, ExUrban.post_headers, opts
      :post   -> ExUrban.post endpoint, JSON.encode!(object), ExUrban.post_headers, opts
      :put    -> ExUrban.put endpoint, JSON.encode!(object), ExUrban.post_headers, opts
      :delete -> ExUrban.delete endpoint, ExUrban.post_headers, opts
    end

    case res do
      {:ok, %HTTPoison.Response{status_code: ^status, body: body}} -> {:ok, body}
      {:ok, %HTTPoison.Response{status_code: _, body: body}}       -> {:fail, body}
      {:error, %HTTPoison.Error{reason: reason}}                   -> {:fail, [error: reason]}
    end

  end
end

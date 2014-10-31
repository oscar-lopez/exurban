defmodule ExUrban do
  use HTTPoison.Base
  use Jazz

  defmodule Push do
    defstruct audience: %{},
              notification: %{},
              device_types: []
  end

  @moduledoc """
  Simple wrapper for Urban Airship. Right now, you can use the basic `%ExUrban.Push{}`
  struct for sending a push. You can use the same format as the Urban Airship REST API.
  """

  @ua_version 3

  @ua_master Application.get_env(:urban, :ua_master)
  @ua_key    Application.get_env(:urban, :ua_key)
  @ua_secret Application.get_env(:urban, :ua_secret)

  @endpoint "https://go.urbanairship.com/api/"

  #####
  # Public API

  @doc """
  Creates the URL for the main API entrypoint.

  ## Example

      iex> endpoint = "push"
      ...> ExUrban.process_url(endpoint)
      "https://go.urbanairship.com/api/push"
  """
  def process_url(url) do
    @endpoint <> url
  end


  @doc """
  Decodes the body into a map.

  ## Example

      iex> body = ~S/{"field": "value"}/
      ...> ExUrban.process_response_body(body)
      [field: "value"]
  """
  def process_response_body(body) do
    case String.length body do
      0 -> %{status: :deleted} # Body is empty when replying to a DELETE request
      _ ->
        json = JSON.decode! to_string(body)
        json = Enum.map json, fn({k, v}) -> {String.to_atom(k), v} end
        json
    end
  end

  @doc """
  Builds and sends a query to Urban Airship.
  """
  def query(endpoint, body) do
    res = ExUrban.post(endpoint, JSON.encode!(body), post_headers, [hackney: make_auth])
    case res do
      {:ok, %HTTPoison.Response{status_code: 202, body: body}} -> {:ok, body}
      {:ok, %HTTPoison.Response{status_code: _, body: body}}   -> {:fail, body}
      {:error, %HTTPoison.Error{reason: reason}}               -> {:fail, reason}
    end
  end

  @doc """
  Sends a push message to Urban Airship.
  """
  def push(body, opts \\ {}) do
    query("push", body)
  end

  #####
  # Private

  defp make_auth do
    [basic_auth: {@ua_key, @ua_master}]
  end

  defp post_headers do
    [{"Accept", "application/vnd.urbanairship+json; version=#{@ua_version};"},
     {"Content-Type", "application/json"}]
  end

end

defmodule ExUrban.Utils do
  use Jazz

  def query(method, status, endpoint, object \\ %{}) do
    auth = [hackney: ExUrban.make_auth]
    res = case method do
      :get    -> ExUrban.get endpoint, ExUrban.post_headers, auth
      :post   -> ExUrban.post endpoint, JSON.encode!(object), ExUrban.post_headers, auth
      :put    -> ExUrban.put endpoint, JSON.encode!(object), ExUrban.post_headers, auth
      :delete -> ExUrban.delete endpoint, ExUrban.post_headers, auth
    end

    case res do
      {:ok, %HTTPoison.Response{status_code: ^status, body: body}} -> {:ok, body}
      {:error, %HTTPoison.Error{reason: reason}}                  -> {:fail, reason}
    end

  end
end

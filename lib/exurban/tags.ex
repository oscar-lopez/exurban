defmodule ExUrban.Tags do
  alias ExUrban.Utils

  defmodule Tag do
    defstruct device_tokens: %{}
  end

  def subscribe(apid, tag) do
    tags = %ExUrban.Tags.Tag{device_tokens: %{add: [apid]}}
    Utils.query :post, 200, "tags/#{tag}", tags
  end

  def unsubscribe(apid, tag) do
    tags = %ExUrban.Tags.Tag{device_tokens: %{remove: [apid]}}
    Utils.query :post, 200, "tags/#{tag}", tags
  end

  def create(tag, list) do
    Utils.query :put, 201, "tags/#{tag}", list
  end

  def delete(tag) do

  end

  def all do
    Utils.query :get, 200, "tags"
  end

  def mass_modify(tags) do

  end
end

# ExUrban #

Elixir wrapper for UrbanAirship API. This is a work in progress.

## Installation ##

Add as a dependency to your application:

```elixir
defp deps do
  [{:exurban, "~> 0.0.1"}]
end
```

Start `ExUrban` within your application:

```elixir
def applications do
  [applications: [:logger, :exurban]]
end
```

Install and compile the dependencies:

```shell
$ mix do deps.get, compile
```

## Configuration ##

You should add your API keys to your `config/#{env}.exs`.

## Documentation ##

Brief usage:

```shell
iex -S mix
...
iex> ExUrban.start
iex> ExUrban.push %{notification: ...}
```

You can pass a map with all the options and values you want. For more
information about the fields please refer to the official Urban
Airship documentation.

## Testing ##

```shell
$ mix test
```

## Contributing ##

Fork the repo and work on a branch. Once you have your feature, bugfix
or anything ready commit please create a new pull request.

## Status ##

*Alpha quality*.

## License ##

Simplified BSD License. See `LICENSE`.

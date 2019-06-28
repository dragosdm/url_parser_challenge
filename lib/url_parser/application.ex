defmodule UrlParser.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: UrlParser.Worker.start_link(arg)
      # {UrlParser.Worker, arg}
      {Plug.Cowboy, scheme: :http, plug: UrlParser.Router, options: [port: http_port()]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: UrlParser.Supervisor]

    Logger.info("Starting application ...")

    Supervisor.start_link(children, opts)
  end

  defp http_port, do: Application.get_env(:url_parser, :port, 8080)
end

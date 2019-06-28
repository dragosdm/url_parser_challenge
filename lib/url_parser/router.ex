defmodule UrlParser.Router do
  use Plug.Router
  use Plug.ErrorHandler

  require Logger

  alias UrlParser.HttpPlug

  plug Plug.Parsers, parsers: [:json],
                     pass:  ["application/json"],
                     json_decoder: Jason
  plug HttpPlug, fields: ["url", "assets", "links"], paths: ["/parser"]

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "POST something to /parser")
  end

  post "/parser" do
    %{"assets" => assets, "links" => links, "url" => url} = conn.params
    with {:ok, host} <- UrlParser.valid_host?(url),
         {:ok, _} <- UrlParser.check_host(host) do
      content = UrlParser.fetch(%{url: url, assets: assets, links: links})
      send_resp(conn, 200, Jason.encode!(content))
    else
      _ -> send_resp(conn, 400, "Invalid URL")
    end
  end

  match _ do
    send_resp(conn, 404, "404! It's not me, it's you!")
  end

  defp handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
    Logger.debug("\nKind: #{inspect(kind)}\nReason: #{inspect(reason)}\nStack: #{inspect(stack)}")

    send_resp(conn, conn.status, "Bad Request")
  end
end

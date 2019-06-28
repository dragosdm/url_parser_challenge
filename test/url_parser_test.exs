defmodule UrlParserTest do
  use ExUnit.Case
  use Plug.Test

  alias UrlParser.Router

  @opts Router.init([])

  test "greets the world" do
    conn =
      :get
      |> conn("/", "")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
  end

  @tag capture_log: true
  test "returns 400 Bad request" do
    assert_raise UrlParser.HttpPlug.IncompleteRequestError, fn ->
      :post
      |> conn("/parser", %{url: "http://some_url.tld", assets: "yes"})
      |> Router.call(@opts)
    end
  end

  test "returns 404" do
    conn =
      :get
      |>conn("/404", "")
      |>Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 404
  end
end

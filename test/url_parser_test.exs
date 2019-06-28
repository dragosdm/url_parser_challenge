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

  test "returns JSON object with links for all images" do
    conn =
      :post
      |> conn("/parser", %{
        url: "https://blackrockdigital.github.io/startbootstrap-shop-homepage/",
        assets: "yes",
        links: "no"
      })
      |> Router.call(@opts)

    response = conn.resp_body |> Jason.decode!()

    assert conn.status == 200
    assert length(response["images"]) == 9
  end

  test "returns JSON object with href links" do
    conn =
      :post
      |> conn("/parser", %{
        url: "https://blackrockdigital.github.io/startbootstrap-shop-homepage/",
        assets: "no",
        links: "yes"
      })
      |> Router.call(@opts)

    response = conn.resp_body |> Jason.decode!()

    assert conn.status == 200
    assert length(response["links"]) == 22
  end

  test "returns JSON object with href links and links for all images" do
    conn =
      :post
      |> conn("/parser", %{
        url: "https://blackrockdigital.github.io/startbootstrap-shop-homepage/",
        assets: "yes",
        links: "yes"
      })
      |> Router.call(@opts)

    response = conn.resp_body |> Jason.decode!()

    assert conn.status == 200
    assert length(response["links"]) == 22
    assert length(response["images"]) == 9
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

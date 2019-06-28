defmodule UrlParser do
  @moduledoc """
  Fetch url and extract links for images and href
  """
  def fetch(%{url: url, assets: "yes", links: "yes"}) do
    fetch(url, 0)
  end
  def fetch(%{url: url, assets: "yes", links: "no"}) do
    fetch(url, 1)
  end
  def fetch(%{url: url, assets: "no", links: "yes"}) do
    fetch(url, -1)
  end
  def fetch(%{url: url, assets: "no", links: "no"}) do
    %{links: [], images: []}
  end
  def fetch(url, what) when what == 0 do
    task = Task.async(fn -> fetch(url , 1) end)
    res = fetch(url, -1)
    links = Task.await(task)

    %{links: res.links, images: links.images}
  end
  def fetch(url, what) when what == 1 do
    srcs = get_links(url, "img", "src")

    %{images: Kernel.--(srcs, [hd(srcs)])}
  end
  def fetch(url, what) when what == -1 do
    hrefs = get_links(url, "a", "href")

    %{links: Kernel.--(hrefs, [hd(hrefs)])}
  end

  def valid_host?(url) do
    case URI.parse(url) do
      %URI{scheme: nil} -> {:error, "Scheme not present"}
      %URI{host: nil, path: nil} -> {:error, "Host not present"}
      %URI{host: nil, path: _} -> {:error, "Host not present"}
      %URI{host: host} -> {:ok, host}
    end
  end

  def check_host(host) do
    if :inet.gethostbyname(to_charlist(host)) != {:error, :nxdomain},
       do: {:ok, host}, else: {:error, "Invalid URL"}
  end

  def get_links(url, type, src) do
    headers = []
    options = [follow_redirect: true]
    url
    |> HTTPoison.get(headers, options)
    |> handle_response(url, type, src)
  end

  def handle_response({:ok, %{body: body}}, url, type, src) do
    [url | body
           |> Floki.find(type)
           |> Floki.attribute(src)
           |> Enum.map(&URI.merge(url, &1)) # handle relative URLS by merging them with URI
           |> Enum.map(&to_string/1)       # Convert the merged URL to a string
           |> List.flatten]
  end

  def handle_response(_response, url) do
    [url]
  end
end

defmodule UrlParser.MixProject do
  use Mix.Project

  def project do
    [
      app: :url_parser_challenge,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {UrlParser.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.1"},
      {:floki, "~> 0.21.0"},
      {:html5ever, "~> 0.7.0"}, #requires RUST to compile
      {:httpoison, "~> 1.5"},
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false}
    ]
  end
end

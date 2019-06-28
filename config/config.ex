use Mix.config

config :logger, :console,
       format: "\n$time $metadata[$level] $levelpad$message\n",
       metadata: [:user_id]

#Requires rust to compile and is used for better performance and accurate parser
config :floki, :html_parser, Floki.HTMLParser.Html5ever

config :url_parser, port: 8080
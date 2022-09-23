import Config

config :rest_api,
  ecto_repos: [Friends.Repo]

config :rest_api, Friends.Repo,
  database: "rest_api_repo",
  username: "nadi",
  password: "postgres",
  hostname: "localhost"

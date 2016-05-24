defmodule Domainr do
  @moduledoc """
  HTTP Client for domainr.
  """
  use Application
  use HTTPoison.Base

  @doc """
  Starting the Domainr.Supervisor
  """
  def start(_type, _args) do
    Domainr.Supervisor.start_link
  end

  defp key do
    Application.get_env(:mashape, :key) ||
      System.get_env("MASHAPE_KEY")
  end

  defp process_url(url) do
    "https://domainr.p.mashape.com" <> url
  end

  defp process_request_headers(headers) do
    [
     {'X-Mashape-Key', key() },
     {'Accept', 'application/json'} | headers
    ]
  end

  defp process_response_body(body) do
    body
    |> Poison.decode!
  end
end

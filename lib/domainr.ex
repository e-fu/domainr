defmodule Domainr do
  @moduledoc """
  HTTP Client for Domainr API.

  This module provides functions to interact with the Domainr API, including
  searching for domain names and checking their status.

  ## Examples

      iex> Domainr.get!("/v2/status?domain=example.com")
      %{"status" => [...]}

      iex> Domainr.get!("/v2/search?query=acme+cafe")
      %{"results" => [...]}
  """
  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      {Finch, name: Domainr.Finch}
    ]

    opts = [strategy: :one_for_one, name: Domainr.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def key do
    System.get_env("RAPIDAPI_KEY") || raise "RAPIDAPI_KEY not set in environment"
  end

  defp base_url do
    "https://domainr.p.rapidapi.com"
  end

  defp process_url(url) do
    base_url() <> url
  end

  defp process_request_headers(headers) do
    [
      {"x-rapidapi-host", "domainr.p.rapidapi.com"},
      {"x-rapidapi-key", key()},
      {"Accept", "application/json"} | headers
    ]
  end

  defp process_response_body(body) do
    body
    |> Jason.decode!()
  end

  @doc """
  Makes a GET request to the given URL and processes the response.

  ## Examples

      iex> Domainr.get!("/v2/status?domain=example.com")
      %{"status" => [...]}

      iex> Domainr.get!("/v2/search?query=acme+cafe")
      %{"results" => [...]}
  """
  def get!(url) do
    url = process_url(url)
    headers = process_request_headers([])

    case Finch.build(:get, url, headers) |> Finch.request(Domainr.Finch) do
      {:ok, %Finch.Response{status: 200, body: body}} ->
        process_response_body(body)

      {:ok, %Finch.Response{status: status, body: body}} ->
        Logger.error("HTTP request failed with status #{status}: #{body}")
        raise "HTTP request failed with status #{status}: #{body}"

      {:error, reason} ->
        Logger.error("HTTP request failed: #{reason}")
        raise "HTTP request failed: #{reason}"
    end
  end
end

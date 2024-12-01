defmodule Domainr.Search do
  @moduledoc """
  Domainr search function(s).

  This module provides functions to search for domain names using the Domainr API.

  ## Examples

      iex> Domainr.Search.find("acme+cafe")
      %{"results" => [...]}

      iex> Domainr.Search.find("acme+cafe", %Domainr.Search{location: "de", registrar: "namecheap.com", defaults: "bike,cab"})
      %{"results" => [...]}

      iex> Domainr.Search.locale_find("acme+cafe", "de")
      %{"results" => [...]}
  """
  alias __MODULE__
  defstruct defaults: "", location: "", registrar: ""

  @doc """
  Search for terms and get some domain suggestions.

  ## Parameters

    - `terms`: The term(s) to search against (required).

  ## Examples

      iex> Domainr.Search.find("acme+cafe")
      %{"results" => [...]}
  """
  def find(terms) when is_binary(terms) and terms != "" do
    sanitized_terms = URI.encode(terms)
    result = Domainr.get!("/v2/search?query=" <> sanitized_terms)

    case result do
      %{"errors" => _} -> result["errors"]
      %{"results" => _} -> result["results"]
      _ -> []
    end
  end

  def find(_terms), do: []

  @doc """
  Search for terms and get some domain suggestions with additional parameters.

  ## Parameters

    - `terms`: The term(s) to search against (required).
    - `search`: A `%Domainr.Search{}` struct with optional parameters.

  ## Examples

      iex> Domainr.Search.find("acme+cafe", %Domainr.Search{location: "de", registrar: "namecheap.com", defaults: "bike,cab"})
      %{"results" => [...]}
  """
  def find(terms, %Search{defaults: defaults, location: location, registrar: registrar}) do
    new_term =
      terms <>
        "&defaults=" <>
        URI.encode(defaults) <>
        "&location=" <>
        URI.encode(location) <>
        "&registrar=" <> URI.encode(registrar)

    find(new_term)
  end

  @doc """
  Search for terms and get some domain suggestions for a specific locale.

  ## Parameters

    - `terms`: The term(s) to search against (required).
    - `locale`: The locale to search in (required).

  ## Examples

      iex> Domainr.Search.locale_find("acme+cafe", "de")
      %{"results" => [...]}
  """
  def locale_find(terms, locale) do
    find(terms, %Domainr.Search{location: locale})
  end
end

defmodule Domainr.Search do
  @moduledoc """
  Domainr search function(s)
  """
  alias __MODULE__
  defstruct defaults: "", location: "", registrar: ""

  @doc """
  Search for terms and get some domain suggestions.
  # Term(s) to search against (required).
  `acme+cafe`

  # Example:
      find("acme+cafe")
  """
  def find(terms) do
    result = Domainr.get!("/v2/search?query=" <> terms).body
    case result do
      %{"errors" => _ } ->  result["errors"]
      %{"results" => _ } -> result["results"]
      _ -> result
    end
  end

  def locale_find(terms, locale) do
    find(terms, %Domainr.Search{location: locale})
  end

  @doc ~S"""
  Search for terms and get some domain suggestions.

  # Term(s) to search against (required).

  `"acme+cafe"`

  # location (optional)
  Optionally for country-code zones, with a two-character country code.

  `location: "de"`

  # registrar (optional)
  The domain name of a specific registrar to filter results by that registrar’s supported list of extensions (optional).

  `registrar: "namecheap.com"`

  # defaults (optional)
  Optional comma-separated list of default zones to include in the response.

  `defaults: "bike,cab"`

  # Example:
      find("acme+cafe", %Domainr.Search{location: "de",
      registrar: "namecheap.com", defaults: "bike,cab"})
  """
  def find(terms, %Search{defaults: defaults, location: location, registrar: registrar}) do
    new_term = terms <>
      "&defaults="   <> defaults  <>
      "&location="   <> location  <>
      "&registrar="  <> registrar

    find(new_term)
  end
end

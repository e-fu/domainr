defmodule Domainr.Status do
  @moduledoc """
  Search the status for (a) given domain(s).

  This module provides functions to check the status of domain names using the Domainr API.

  ## Examples

      iex> Domainr.Status.get("google.com,google.de")
      %{"status" => [...]}

      iex> Domainr.Status.find_free_tlds_for("google", [".com", ".de"])
      %{"status" => [...]}
  """

  @doc """
  Get the status for a string with domains.

  ## Parameters

    - `domains`: A comma-separated string of domains to check the status for (required).

  ## Examples

      iex> Domainr.Status.get("google.com,google.de")
      %{"status" => [...]}
  """
  def get(domains) do
    result = Domainr.get!("/v2/status?domain=" <> URI.encode(domains))

    case result do
      %{"errors" => _} -> result
      %{"status" => _} -> result["status"]
      _ -> result
    end
  end

  @doc """
  Search free TLDs for a given domain.

  ## Parameters

    - `domain`: The domain to check for free TLDs (required).
    - `list`: A list of TLDs to check (required).

  ## Examples

      iex> Domainr.Status.find_free_tlds_for("google", [".com", ".de"])
      %{"status" => [...]}
  """
  def find_free_tlds_for(domain, list) when is_list(list) and is_binary(domain) do
    list
    |> Enum.map(&"#{domain}#{&1}")
    |> Enum.join(",")
    |> get()
    |> case do
      %{"errors" => _} = error -> error
      status -> find_inactive(status)
    end
  end

  defp find_inactive(results) do
    Enum.filter(results, fn x ->
      String.contains?(x["status"], ["inactive"])
    end)
  end
end

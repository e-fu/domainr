defmodule Domainr.Register do
  @moduledoc """
  Get registrar information for a given domain.

  This module provides functions to get registrar information using the Domainr API.

  ## Examples

      iex> Domainr.Register.get("google.com")
      %{"registrar" => [...]}

      iex> Domainr.Register.get("example.com")
      %{"redirect_url" => "https://iwantmyname.com/partner/search?r=domai.nr&u=303669&b=210737&q=example.com"}
  """

  @doc """
  Get registrar information for a domain.

  ## Parameters

    - `domain`: The domain to get registrar information for (required).
    - `registrar`: The registrar to use for the request (optional).

  ## Examples

      iex> Domainr.Register.get("google.com")
      %{"registrar" => [...]}

      iex> Domainr.Register.get("example.com", "namecheap.com")
      %{"redirect_url" => "https://iwantmyname.com/partner/search?r=domai.nr&u=303669&b=210737&q=example.com"}
  """
  def get(domain, registrar \\ nil) do
    url = "/v2/register?domain=" <> URI.encode(domain)
    url = if registrar, do: url <> "&registrar=" <> URI.encode(registrar), else: url

    IO.inspect(url)

    result = Domainr.get!(url)

    case result do
      %{"errors" => _} -> result
      %{"redirect_url" => redirect_url} -> %{"redirect_url" => redirect_url}
      %{"registrar" => _} -> result["registrar"]
      _ -> result
    end
  end
end

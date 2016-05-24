defmodule Domainr.Status do
  @moduledoc """
  Search the status for (a) given domain(s).
  """

  @doc """
  Get the status for a string with domains.
      Example: status("google.com,google.de")


  Read: http://domainr.build/docs/status for possible status outcomes.
  """
  def get(domains) do
    result = Domainr.get!("/v2/status?domain=" <> domains).body
    case result do
      %{"errors" => _ } -> result
      %{"status" => _ } -> result["status"]
      _ -> result
    end
  end

  @doc """
  Search free tlds for a given domain.
      Example: find_free_tlds("google", [".com",".de"])
  """
  def find_free_tlds_for(domain, list) when is_list(list) and is_binary(domain) do
    list
    |> building_domains(domain)
    |> get()
    |> find_inactive()
  end

  defp building_domains(list, domain) do
    Stream.map(list, fn(x) -> domain <> to_string(x) end)
    |> Enum.join(",")
  end

  defp find_inactive(results) do
    Enum.filter(results, fn(x) ->
      String.contains?(x["status"],["inactive"])
    end)
  end
end

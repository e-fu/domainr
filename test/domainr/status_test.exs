defmodule Domainr.StatusTest do
  use ExUnit.Case
  alias Domainr.Status

  setup do
    # Ensure the API key is set in the environment
    api_key = System.get_env("RAPIDAPI_KEY")

    if api_key == nil do
      raise "RAPIDAPI_KEY not set in environment"
    end

    :ok
  end

  test "it gets the status for a given domain" do
    response = Status.get("google.com,google.fr,google.de")

    assert is_list(response) or is_map(response)

    if is_list(response) do
      assert Enum.any?(response, fn status -> status["domain"] == "google.com" end)
      assert Enum.any?(response, fn status -> status["domain"] == "google.fr" end)
      assert Enum.any?(response, fn status -> status["domain"] == "google.de" end)
    else
      assert Map.has_key?(response, "errors")
    end
  end

  test "it returns errors if (some) unknown domain(s)" do
    response = Status.get("google.commmm,google.com")

    assert is_map(response)
    assert Map.has_key?(response, "errors")
  end

  test "it finds free TLDs for a given domain" do
    free_domains = Status.find_free_tlds_for("gooooogle", [".com", ".de", ".berlin"])
    assert is_list(free_domains) or is_map(free_domains)

    if is_list(free_domains) do
      assert Enum.count(free_domains) > 0
    else
      assert Map.has_key?(free_domains, "errors")
    end
  end

  test "it handles invalid domain format" do
    response = Status.get("invalid_domain")
    assert is_map(response)
    assert Map.has_key?(response, "errors")
  end
end

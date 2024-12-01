defmodule Domainr.SearchTest do
  use ExUnit.Case
  alias Domainr.Search

  setup do
    # Ensure the API key is set in the environment
    api_key = System.get_env("RAPIDAPI_KEY")

    if api_key == nil do
      raise "RAPIDAPI_KEY not set in environment"
    end

    :ok
  end

  test "it searches for terms" do
    results = Search.find("google+mail")
    assert is_list(results)
    assert Enum.count(results) > 0
  end

  test "it searches for terms to include GEO zones" do
    results = Search.find("google+mail", %Search{location: "de"})
    assert is_list(results)
    assert Enum.any?(results, fn result -> result["domain"] == "googlemail.de" end)
  end

  test "searches for a different region TLD" do
    results = Search.find("acme+cafe", %Search{location: "de"})
    assert is_list(results)
    assert Enum.count(results) > 0
  end

  test "searches for a different region TLD with shortcut" do
    results = Search.locale_find("acme+cafe", "de")
    assert is_list(results)
    assert Enum.count(results) > 0
  end

  test "it returns errors" do
    results = Search.find("domainr")
    assert is_list(results)
    assert Enum.count(results) > 0
  end

  test "it handles empty search term" do
    results = Search.find("")
    assert is_list(results)
    assert Enum.count(results) == 0
  end

  test "it sanitizes search terms" do
    results = Search.find("google mail")
    assert is_list(results)
    assert Enum.count(results) > 0
  end
end

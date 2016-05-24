defmodule Domainr.SearchTest do
  use ExUnit.Case

  @tag :skip
  test "it searches for terms" do
    results = Domainr.Search.find("google+mail")
    assert Enum.count(results) == 16
  end

  @tag :skip
  test "it searches for terms to include GEO zones" do
    results = Domainr.Search.find("google+mail", %Domainr.Search{location: "de"})
    de = Enum.filter(results, fn(x) ->
      x["domain"] == "googlemail.de"
    end)
    assert Enum.count(de) == 1
  end

  @tag :skip
  test "searches for a different region tld" do
    results = Domainr.Search.find("acme+cafe", %Domainr.Search{location: "de"})
    # |> IO.inspect
    assert Enum.count(results) > 5
  end

  @tag :skip
  test "searches for a different region tld with shortcut" do
    results = Domainr.Search.locale_find("acme+cafe", "asdfasdf")
    # |> IO.inspect
    assert Enum.count(results) > 5
  end

  @tag :skip
  test "it returns errors" do
    results = Domainr.Search.find("domainr")
    assert Enum.count(results) > 5
  end
end

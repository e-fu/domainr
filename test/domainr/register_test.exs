defmodule Domainr.RegisterTest do
  use ExUnit.Case
  alias Domainr.Register

  setup do
    # Ensure the API key is set in the environment
    api_key = System.get_env("RAPIDAPI_KEY")

    if api_key == nil do
      raise "RAPIDAPI_KEY not set in environment"
    end

    :ok
  end

  test "it gets registrar information for a given domain" do
    response = Register.get("google.com")
    assert is_map(response)

    if Map.has_key?(response, "redirect_url") do
      assert response["redirect_url"] ==
               "https://iwantmyname.com/partner/search?r=domai.nr&u=303669&b=210737&q=google.com"
    else
      assert Map.has_key?(response, "registrar")
    end
  end

  test "it gets registrar information for a given domain with a specific registrar" do
    response = Register.get("google.com", "namecheap.com")
    assert is_map(response)

    if Map.has_key?(response, "redirect_url") do
      assert response["redirect_url"] ==
               "https://iwantmyname.com/partner/search?r=domai.nr&u=303669&b=210737&q=google.com"
    else
      assert Map.has_key?(response, "registrar")
    end
  end

  test "it handles invalid domain format" do
    response = Register.get("invalid_domain")
    assert is_map(response)
    assert Map.has_key?(response, "errors")
  end
end

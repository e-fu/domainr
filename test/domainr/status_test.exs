defmodule Domainr.StatusTest do
  use ExUnit.Case

  @moduledoc """
  Actual outcome can be different!
  """

  setup do
    status = [
      %{"domain" => "google.com",
        "status" => "active registrar", "summary" => "registrar",
        "zone" => "com"},
      %{"domain" => "google.fr", "status" => "active",
        "summary" => "active", "zone" => "fr"},
      %{"domain" => "google.de", "status" => "active",
        "summary" => "active", "zone" => "de"}
    ]

    # more_than_10 = [
    #   ".de", ".com", ".fr", ".it", ".io", ".net",
    #   ".org", ".es", ".co", ".club", ".berlin", ".gmbh"
    # ]

    with_errors = %{
      "errors" => [%{"code" => 404,
                     "detail" => "google.commmm",
                     "message" => "Domain not found"}
                  ],
      "status" => [%{"domain" => "google.com",
                     "status" => "active registrar", "summary" => "registrar",
                     "zone" => "com"}
                  ]
    }

    {:ok, status: status, with_errors: with_errors}
  end

  @tag :skip
  test "it get the status for a given domain", %{status: status} do
    response = Domainr.Status.get("google.com,google.fr,google.de")
    assert response == status
  end

  @tag :skip
  test "it returns errors if (some) unkown domain(s)", %{with_errors: with_errors} do
    response = Domainr.Status.get("google.commmm,google.com")
    assert response == with_errors
  end

  @tag :skip
  test "which domains are free" do
    free_domains = Domainr.Status.find_free_tlds_for("gooooogle", [".com",".de",".berlin"])
    assert Enum.count(free_domains) == 1
  end
end

defmodule Domainr.Mixfile do
  use Mix.Project

  @version "0.0.2"

  def project do
    [
      app: :domainr,
      version: @version,
      elixir: "~> 1.14",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [extras: ["README.md"]],
      description: description(),
      package: package(),
      name: "Domainr",
      source_url: "https://github.com/e-fu/domainr"
    ]
  end

  defp description do
    ~S"""
    Domainr is an [Domainr wrapper for](https://domainr.build) in Elixir that
    makes it easy to search and find available domains and TLDs.
    """
  end

  def package do
    [
      name: :domainr,
      maintainers: ["E.FU"],
      licenses: ["MIT"],
      links: %{GitHub: "https://github.com/e-fu/domainr"}
    ]
  end

  def application do
    [
      mod: {Domainr, []}
    ]
  end

  defp deps do
    [
      {:finch, "~> 0.10"},
      {:jason, "~> 1.4"},
      {:earmark, "~> 1.4", only: :dev},
      {:ex_doc, "~> 0.25", only: :dev}
    ]
  end
end

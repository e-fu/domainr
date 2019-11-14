defmodule Domainr.Mixfile do
  use Mix.Project

  def project do
    [app: :domainr,
     version: "0.0.1",
     description: description,
     package: package,
     name: "Domainr",
     source_url: "https://github.com/e-fu/domainr",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     docs: [extras: ["README.md"]]
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
      # files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["E.FU"],
      licenses: ["MIT"],
      links: %{GitHub: "https://github.com/e-fu/domainr"}
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison],
     mod: {Domainr, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:poison, "~> 4.0"},
      {:httpoison, "~> 0.8.0"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev}
    ]
  end
end

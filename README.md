# Domainr

  Domainr is a [Domainr wrapper for](https://domainr.build) in Elixir
  making it easy to search and find (available) domains and TLDs.

## Installation

1. Add Domainr to your list of dependencies in `mix.exs`:

        def deps do
          [{:domainr, "~> 0.0.1"}]
        end

2. Ensure Domainr is started before your application:

        def application do
          [applications: [:domainr]]
        end

3. Add your API key from [mashape](http://docs.mashape.com/api-keys):

        # Step 1 (in your ENV)
        export RAPIDAPI_KEY="YOUR_API_KEY"

        # Step 2 (optional)
        config :rapidapi,
          key: System.get_env("RAPIDAPI_KEY")

## Usage

  Do easily find the status for one or more domains:

    Domainr.Status.get("google.com,domainr.build")

  You have a domain name in mind and want to check for the available TLDs?

    Domainr.Status.find_free_tlds_for("awesomename", [".com",".io"])

  You need some suggestions for domain names?

    Domainr.Search.find("green+coffee")

  You want to be more specific in your search?

    # Be more local (here for germany):

    Domainr.Search.find("gruener+kaffee", %Domainr.Search{location: "de"})
    # Shortcut
    Domainr.Search.locale_find("gruener+kaffee", "de")

    # You have some TLDs in mind?
    Domainr.Search.find("green+coffee", %Domainr.Search{defaults: "coffee,club"})


## Authorship and License

  Domainr is copyright 2016 inetpeople holding pte ltd.

  Domainr is released under the
  [MIT License](https://github.com/e-fu/domainr/blob/master/LICENSE).

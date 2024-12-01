# Domainr

  Domainr is a [Domainr wrapper for](https://domainr.build) in Elixir
  making it easy to search and find (available) domains and TLDs.




## Installation

1. Add Domainr to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:domainr, "~> 0.0.2"}]
end
```
2. Ensure Domainr is started before your application:

```elixir
def application do
  [mod: {Domainr, []}]
end
```

3. Add your API key from RAPIDAPI or Domainr

For RapidAPI (free or non-commercial use):
```sh
export RAPIDAPI_KEY="YOUR_API_KEY"
```

_or_

For high-volume, commercial use:
```sh
export DOMAINR_API_KEY="YOUR_API_KEY"
```
and set 4. as it is no longer optional.


4. (Optional) Set the base URL for the API:

https://api.domainr.com (high-volume, commercial use)
https://domainr.p.rapidapi.com (free or non-commercial use)

```elixir
config :domainr, base_url: "https://api.domainr.com"

```

## Usage

Do easily find the status for one or more domains:

```elixir
Domainr.Status.get("google.com,domainr.build")
```

You have a domain name in mind and want to check for the available TLDs?

```elixir
Domainr.Status.find_free_tlds_for("awesomename", [".com",".io"])
```

You need some suggestions for domain names?

```elixir
Domainr.Search.find("green+coffee")
```

# You want to be more specific in your search?

Be more local (here for germany):

```elixir
Domainr.Search.find("gruener+kaffee", %Domainr.Search{location: "de"})
# Shortcut
Domainr.Search.locale_find("gruener+kaffee", "de")
```

You have some TLDs in mind?

```elixir
    Domainr.Search.find("green+coffee", %Domainr.Search{defaults: "coffee,club"})
```

You want to get registrar information for a domain?

```elixir
Domainr.Register.get("example.com")
```

## Authorship and License

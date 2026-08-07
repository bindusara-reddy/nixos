{
  # Local SearXNG metasearch, loopback-only — hermes's web-search backend
  # (SEARXNG_URL in ~/.hermes/.env points here). Keyless and immune to the
  # DuckDuckGo rate-limit lottery that the ddgs scraper loses; the nix-built
  # hermes env doesn't even ship the optional `ddgs` package.
  services.searx = {
    enable = true;
    settings = {
      server = {
        bind_address = "127.0.0.1";
        port = 8888;
        # loopback-only instance: this key only signs local session/CSRF
        # state, so it can live in the repo — rotate it if searx ever binds
        # beyond 127.0.0.1
        secret_key = "24bfacc81e6ca4108aeb3d3c80d141c102c656b99566a6b9";
        limiter = false; # bot-limiter needs valkey and only matters when public
      };
      # hermes queries /search?format=json — searxng rejects formats not listed
      search.formats = ["html" "json"];
    };
  };
}

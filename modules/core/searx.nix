{pkgs, ...}: let
  secretFile = "/var/lib/searx/secrets.env";
in {
  # Local SearXNG metasearch, loopback-only — hermes's web-search backend
  # (SEARXNG_URL in ~/.hermes/.env points here). Keyless and immune to the
  # DuckDuckGo rate-limit lottery that the ddgs scraper loses; the nix-built
  # hermes env doesn't even ship the optional `ddgs` package.
  services.searx = {
    enable = true;
    environmentFile = secretFile;
    settings = {
      server = {
        bind_address = "127.0.0.1";
        port = 8888;
        # Expanded from environmentFile when searx-init builds settings.yml.
        secret_key = "$SEARXNG_SECRET";
        limiter = false; # bot-limiter needs valkey and only matters when public
      };
      # hermes queries /search?format=json — searxng rejects formats not listed
      search.formats = ["html" "json"];
    };
  };

  # Create the key once on the machine, outside both Git and the Nix store.
  systemd.services.searx-secret = {
    description = "Create the private SearXNG session secret";
    requiredBy = ["searx-init.service"];
    before = ["searx-init.service"];
    serviceConfig.Type = "oneshot";
    script = ''
      install -d -m 0750 -o root -g searx /var/lib/searx
      if [ ! -s ${secretFile} ]; then
        secret="$(${pkgs.openssl}/bin/openssl rand -hex 32)"
        umask 0077
        printf 'SEARXNG_SECRET=%s\n' "$secret" > ${secretFile}
        chown root:searx ${secretFile}
        chmod 0640 ${secretFile}
      fi
    '';
  };
}

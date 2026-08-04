{
  pkgs,
  inputs,
  ...
}: {
  # Hermes — Nous Research's self-improving agent CLI (github.com/NousResearch/hermes-agent).
  # First run: `hermes setup` picks a provider (Nous Portal, OpenRouter, OpenAI, …) and
  # stores the key; after that just `hermes`. `hermes gateway start` bridges it to
  # Telegram/Discord/WhatsApp if you ever want that.
  #
  # The flake also ships `tui`/`desktop`/`messaging` package variants and a
  # `services.hermes-agent` NixOS module for an always-on gateway daemon — this
  # installs just the CLI, which is the right shape for a laptop.
  home.packages = [
    inputs.hermes-agent.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}

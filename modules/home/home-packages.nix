{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # cosmic add-ons — applets appear in Settings → Desktop → Panel →
    # Configure applets after install
    cosmic-ext-tweaks # theming/tweak tool (panel roundness, spacing, themes)
    cosmic-ext-applet-caffeine # keep-awake toggle, like the GNOME extension
    cosmic-ext-applet-minimon # CPU/RAM in the panel, like Vitals

    # desktop
    google-chrome
    vlc
    mpv
    mission-center # pretty GUI system monitor
    zapzap # WhatsApp client (there is no official Linux app)
    libreoffice-fresh

    # creation
    blender
    # unstable's freecad is a 1.1 dev snapshot with a broken (blank) 3D viewport
    inputs.nixpkgs-stable.legacyPackages.${pkgs.system}.freecad
    godot

    # cli toolbelt
    ripgrep # grep, but instant (rg)
    fd # find, but sane
    jq
    tree
    unzip
    zip
    p7zip
    ncdu # what's eating my disk (TUI)
    duf # df, but readable
    dust # du, but readable
    tealdeer # tldr <cmd> — man pages' useful cousin
    vivid # generates the gruvbox LS_COLORS used by ls/eza/fd (see nushell.nix)

    # dev
    python3
    uv # the python package manager
    lazydocker

    # gaming
    protonup-qt # GE-Proton installer for Steam
    moonlight-qt # game-stream client for sunshine on deep-blue

    # AI CLIs
    claude-code
    codex
    gemini-cli
  ];
}

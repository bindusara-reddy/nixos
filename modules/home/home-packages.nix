{pkgs, ...}: {
  home.packages = with pkgs; [
    # desktop
    google-chrome
    vlc
    mpv
    mission-center # pretty GUI system monitor
    zapzap # WhatsApp client (there is no official Linux app)

    # creation
    blender
    freecad
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

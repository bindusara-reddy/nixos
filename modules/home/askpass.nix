{
  config,
  pkgs,
  ...
}: let
  # cosmic-comp cascades new floating windows off the previously spawned one
  # (only centering when the stack is empty), and Wayland toplevels can't
  # request a position — so any dialog-based askpass lands wherever the
  # cascade puts it. fuzzel renders on the layer-shell instead and anchors
  # dead center, like the panel itself.
  fuzzelIni = pkgs.writeText "fuzzel-askpass.ini" ''
    [main]
    font=JetBrains Mono:size=12
    anchor=center
    lines=0
    width=34
    horizontal-pad=20
    vertical-pad=14

    [colors]
    background=1b1b1bf2
    text=ffffffff
    prompt=ffad00ff
    input=ffffffff
    border=ffad00ff

    [border]
    width=2
    radius=12
  '';
in {
  home.packages = [
    (pkgs.writeShellScriptBin "sudo-askpass" ''
      # sudo passes the prompt as $1; agents use: sudo -A <cmd>
      # --prompt-only, not --prompt: in dmenu mode fuzzel waits on stdin for the
      # match list, and with </dev/null it sees EOF on an empty list and exits
      # before drawing anything. --prompt-only skips the stdin wait entirely.
      exec ${pkgs.fuzzel}/bin/fuzzel --dmenu --password \
        --config=${fuzzelIni} --prompt-only="''${1:-sudo password: } "
    '')
  ];

  home.sessionVariables.SUDO_ASKPASS = "${config.home.profileDirectory}/bin/sudo-askpass";
}

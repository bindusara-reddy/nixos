{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    settings = {
      "$mod" = "SUPER";
      bind =
        [
          "$mod, Q, exec, wezterm"
          "$mod, F, exec, firefox"
          "$mod, S, exec, rofi -show drun -show-icons"
        ] 
        ++ 
        (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (
            builtins.genList ( i: 
              let ws = i + 1;
              in [
                "$mod, ${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, ${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
          9)
        );
      exec-once = [
        "swww init"
        "swww img /home/bindu/Pictures/himalaya.jpg"
        "nm-applet --indicator" 
        "waybar"
        "dunst"
        "systemctl --user start hyprpolkitagent"
      ];
      input = {
        kb_layout = "us";
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.5;
        };
      };
      monitor = "desc:AU Optronics 0xAF90, preferred, auto, 1";
    };
  }; 
}

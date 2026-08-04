{pkgs, ...}: {
  # extensions get installed here, enabled via dconf below
  # (no gsconnect — the phone is an iPhone; LocalSend covers file drops)
  home.packages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.vitals

    # lets GNOME launch Terminal=true apps (btop, yazi) — its built-in fallback
    # only knows gnome-terminal/console/xterm, all excluded from this config
    xdg-terminal-exec
  ];

  # both the modern spec and the legacy gsettings key point at wezterm,
  # so app-grid launches of terminal apps open in wezterm
  xdg.configFile."xdg-terminals.list".text = ''
    org.wezfurlong.wezterm.desktop
  '';

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "clipboard-indicator@tudmotu.com"
        "dash-to-dock@micxgx.gmail.com"
        "Vitals@CoreCoding.com"
      ];
      favorite-apps = [
        "org.wezfurlong.wezterm.desktop"
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "steam.desktop"
      ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      clock-show-weekday = true;
      show-battery-percentage = true;
      # libadwaita apps ignore GTK themes — the accent color is the only
      # sanctioned way to warm them up; orange ≈ gruvbox #d65d0e
      accent-color = "orange";
      enable-hot-corners = false; # stop accidental overview trips on the touchpad
      monospace-font-name = "JetBrainsMono Nerd Font 10";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/default-applications/terminal" = {
      exec = "wezterm";
      exec-arg = "start";
    };

    # window buttons like a normal OS
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      num-workspaces = 4;
    };

    # fixed 4 workspaces with Super+N switching — the single biggest GNOME
    # workflow upgrade: everything has a place, one chord away
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
      workspaces-only-on-primary = true;
      edge-tiling = true;
    };
    # GNOME claims Super+1..4 for dash favorites by default — free them first
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
    };
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      move-to-workspace-1 = ["<Super><Shift>1"];
      move-to-workspace-2 = ["<Super><Shift>2"];
      move-to-workspace-3 = ["<Super><Shift>3"];
      move-to-workspace-4 = ["<Super><Shift>4"];
    };

    # dock: translucent, only retreats when a window needs the space
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      dash-max-icon-size = 48; # GNOME's normal size — 40 + shrink felt too small
      transparency-mode = "FIXED";
      background-opacity = 0.65;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      click-action = "minimize-or-previews";
      running-indicator-style = "DOTS";
      show-trash = false;
      show-mounts = false;
    };

    # blur the shell chrome (panel/overview/dock) — app blur stays off, it's
    # the buggy half of the extension
    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = true;
      static-blur = true;
    };
    "org/gnome/shell/extensions/blur-my-shell/overview".blur = true;
    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      static-blur = true;
    };
    "org/gnome/shell/extensions/blur-my-shell/applications".blur = false;

    # warm screen at night
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = true;
    };

    # Super+Enter opens a terminal
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "wezterm";
      name = "Terminal";
    };
  };
}

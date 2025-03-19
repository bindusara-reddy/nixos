{ username, ... }: {

  programs.git.enable = true;
  programs.zoxide.enable = true;
  programs.eza.enable = true;

  programs.kitty = {
    
    enable = true;
    themeFile = "tokyo_night_moon";
    settings = {
      scrollback_lines = 2000;
      font_family = "FiraCode Nerd Font Mono";
      font_size = 14.0;
      window_margin_width = 10;
      background_image = "/home/${username}/Pictures/desert.png";
      background_image_layout = "scaled";
      background_tint = 0.9;
      background_tint_gaps = -10.0;
      window_border_width = "1pt";
      active_border_color = "#44ffff";
      single_window_margin_width = 0;
      enabled_layouts = "Tall, *";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      wayland_titlebar_color = "#FFA500";
    };

  };

  programs.zsh = {

    enable = true;
    autosuggestion = {
      enable = true;
      strategy = [ "match_prev_cmd" "completion" "history" ];
    };

    shellAliases = {
      ls = "eza";
    };
 
    syntaxHighlighting = {
      enable = true;
      highlighters = [ "main" "brackets" "cursor" "root" ];
    };
  };

  programs.oh-my-posh = {

    enable = true;
    useTheme = "atomic";

  };

  programs.neovim.defaultEditor = true;
}

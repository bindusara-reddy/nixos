{ username, ... }: {

  programs.kitty = {
    
    enable = true;
    themeFile = "tokyo_night_moon";
    settings = {
      scrollback_lines = 2000;
      font_family = "FiraCode Nerd Font Mono";
      font_size = 14.0;
      window_margin_width = 10;
      background_image = "/home/${username}/Pictures/starry.jpg";
      background_image_layout = "scaled";
      background_tint = 0.7;
      background_tint_gaps = -10.0;
      window_border_width = "1pt";
      active_border_color = "#44ffff";
      single_window_margin_width = 5;
      enabled_layouts = "Tall, *";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      wayland_titlebar_color = "#FFA500";
    };

  };

}

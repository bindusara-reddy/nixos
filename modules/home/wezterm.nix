{

  programs.wezterm = {
    enable = true;
    extraConfig = 
      ''
      return {
	hide_mouse_cursor_when_typing = false,
	inactive_pane_hsb = {
	  saturation = 0.8,
	  brightness = 0.7,
	},
	font = wezterm.font('JetBrains Mono', { weight = 'Regular', italic = false }),
        font_size = 15.0,
	line_height = 1.5,
	adjust_window_size_when_changing_font_size = true,
	initial_rows = 15,
	initial_cols = 80,
	scrollback_lines = 2000,
        color_scheme = "Batman",
	use_dead_keys = false,
	tab_bar_at_bottom = true,
      }
      '';
  };

}

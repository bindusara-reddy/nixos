{

  programs.wezterm = {
    enable = true;
    extraConfig = 
      ''
      return {
  window_decorations = "RESIZE",
	hide_tab_bar_if_only_one_tab = true,
	hide_mouse_cursor_when_typing = false,
	inactive_pane_hsb = {
	  saturation = 0.8,
	  brightness = 0.7,
	},
	font = wezterm.font('JetBrains Mono', { weight = 'Regular', italic = false }),
	font_size = 13.0,
	line_height = 1.5,
	adjust_window_size_when_changing_font_size = true,
	initial_rows = 15,
	initial_cols = 100,
	scrollback_lines = 2000,
        color_scheme = "Gruvbox Dark (Gogh)",
	tab_bar_at_bottom = true,
	keys = {
	  {
	    key = 'w',
	    mods = 'CTRL',
	    action = wezterm.action.CloseCurrentPane { confirm = true },
          },
	  {
	    key = 'h',
	    mods = 'CTRL',
	    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
	  },
	  {
	    key = 'u',
	    mods = 'CTRL',
	    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
	  },
	},
      }
      '';
  };

}

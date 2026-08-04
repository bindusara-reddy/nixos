{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local act = wezterm.action

      local config = {
        window_decorations = "RESIZE",
        hide_tab_bar_if_only_one_tab = true,
        hide_mouse_cursor_when_typing = false,
        inactive_pane_hsb = {
          saturation = 0.8,
          brightness = 0.7,
        },
        -- the nerd-font build, so starship's glyphs actually render
        font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Regular', italic = false }),
        font_size = 13.0,
        line_height = 1.5,
        adjust_window_size_when_changing_font_size = true,
        initial_rows = 15,
        initial_cols = 100,
        scrollback_lines = 10000,
        color_scheme = "Gruvbox Dark (Gogh)",
        tab_bar_at_bottom = true,

        -- One rule: pane/tab things live on ALT, single chord, no leader to
        -- memorize. Plain CTRL keys always reach the shell (^W delete-word,
        -- ^U kill-line, ^A/^E home/end), and wezterm's CTRL|SHIFT defaults
        -- (copy/paste/search/font size) stay untouched.
        keys = {
          -- panes
          { key = '\\', mods = 'ALT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
          { key = '-', mods = 'ALT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
          { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
          { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
          { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
          { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
          { key = 'LeftArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
          { key = 'DownArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
          { key = 'UpArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
          { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
          { key = 'z', mods = 'ALT', action = act.TogglePaneZoomState },
          { key = 'w', mods = 'ALT', action = act.CloseCurrentPane { confirm = true } },
          { key = 'r', mods = 'ALT', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },

          -- tabs
          { key = 't', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
          { key = '[', mods = 'ALT', action = act.ActivateTabRelative(-1) },
          { key = ']', mods = 'ALT', action = act.ActivateTabRelative(1) },
        },

        key_tables = {
          -- ALT+r, then tap hjkl/arrows to resize; Esc or Enter when done
          resize_pane = {
            { key = 'h', action = act.AdjustPaneSize { 'Left', 3 } },
            { key = 'j', action = act.AdjustPaneSize { 'Down', 3 } },
            { key = 'k', action = act.AdjustPaneSize { 'Up', 3 } },
            { key = 'l', action = act.AdjustPaneSize { 'Right', 3 } },
            { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 3 } },
            { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 3 } },
            { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 3 } },
            { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 3 } },
            { key = 'Escape', action = 'PopKeyTable' },
            { key = 'Enter', action = 'PopKeyTable' },
          },
        },
      }

      -- ALT+1..9 jumps straight to that tab
      for i = 1, 9 do
        table.insert(config.keys, { key = tostring(i), mods = 'ALT', action = act.ActivateTab(i - 1) })
      end

      return config
    '';
  };
}

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local act = wezterm.action

      -- gruvbox-dark palette bits used below
      local BG_H = '#1d2021' -- bg0_hard
      local BG1 = '#3c3836'
      local BG2 = '#504945'
      local FG = '#ebdbb2'
      local GRAY = '#928374'
      local YELLOW = '#d79921'

      local config = {
        -- frameless: COSMIC's server-side titlebar clashed with the gruvbox
        -- look; move the window with Super+drag instead
        window_decorations = "NONE",
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

        -- subtle translucency; glyph cells stay solid for readability.
        -- (no blur on GNOME/Mutter — that'd need Blur my Shell's app pipeline)
        window_background_opacity = 0.92,
        text_background_opacity = 1.0,
        -- bottom clears COSMIC's active-window ring, which draws a few px
        -- inside the window edge and was clipping the tab bar
        window_padding = { left = 12, right = 12, top = 12, bottom = 16 },

        -- flash instead of beep
        audible_bell = "Disabled",
        visual_bell = {
          fade_in_duration_ms = 75,
          fade_out_duration_ms = 150,
          target = "CursorColor",
        },

        -- retro tab bar in gruvbox, bottom, no [+] button (ALT+t makes tabs)
        use_fancy_tab_bar = false,
        tab_bar_at_bottom = true,
        tab_max_width = 32,
        show_new_tab_button_in_tab_bar = false,
        status_update_interval = 1000,
        colors = {
          tab_bar = {
            background = BG_H,
            inactive_tab_hover = { bg_color = BG1, fg_color = FG, italic = true },
          },
        },

        -- Only what a person actually does, every one a single ALT+key:
        -- split, move, close, zoom, tabs. Resize panes by dragging the divider
        -- with the mouse. wezterm's CTRL|SHIFT defaults (copy/paste/search)
        -- stay untouched, and plain CTRL keys always reach the shell.
        keys = {
          { key = 'Enter', mods = 'ALT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } }, -- split right
          { key = 's', mods = 'ALT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } }, -- split down ("south")
          { key = 'LeftArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
          { key = 'DownArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
          { key = 'UpArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
          { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
          { key = 'z', mods = 'ALT', action = act.TogglePaneZoomState },
          { key = 'w', mods = 'ALT', action = act.CloseCurrentPane { confirm = true } },
          { key = 't', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
        },
      }

      -- ALT+1..9 jumps straight to that tab
      for i = 1, 9 do
        table.insert(config.keys, { key = tostring(i), mods = 'ALT', action = act.ActivateTab(i - 1) })
      end

      -- tabs as powerline chips: yellow = active, gray = inactive
      local L_DIV = wezterm.nerdfonts.pl_right_hard_divider
      local R_DIV = wezterm.nerdfonts.pl_left_hard_divider
      local function tab_title(tab_info)
        local title = tab_info.tab_title
        if title and #title > 0 then return title end
        return tab_info.active_pane.title
      end
      wezterm.on('format-tab-title', function(tab, tabs, panes, cfg, hover, max_width)
        local bg, fg = BG1, '#a89984'
        if tab.is_active then
          bg, fg = YELLOW, BG_H
        elseif hover then
          bg, fg = BG2, FG
        end
        local title = string.format(' %d %s ', tab.tab_index + 1,
          wezterm.truncate_right(tab_title(tab), max_width - 4))
        return {
          { Background = { Color = BG_H } }, { Foreground = { Color = bg } }, { Text = L_DIV },
          { Background = { Color = bg } },   { Foreground = { Color = fg } }, { Text = title },
          { Background = { Color = BG_H } }, { Foreground = { Color = bg } }, { Text = R_DIV },
        }
      end)

      -- right side of the tab bar: battery + clock
      wezterm.on('update-status', function(window, _)
        local segments = {}
        for _, b in ipairs(wezterm.battery_info()) do
          local icon = b.state == 'Charging' and wezterm.nerdfonts.md_battery_charging or wezterm.nerdfonts.md_battery
          table.insert(segments, string.format('%s %.0f%%', icon, b.state_of_charge * 100))
        end
        table.insert(segments, wezterm.strftime('%a %d %b %H:%M'))
        local colors = { BG1, BG2 }
        local elements = { { Background = { Color = 'none' } } }
        for i, seg in ipairs(segments) do
          local bg = colors[(i - 1) % #colors + 1]
          table.insert(elements, { Foreground = { Color = bg } })
          table.insert(elements, { Text = L_DIV })
          table.insert(elements, { Background = { Color = bg } })
          table.insert(elements, { Foreground = { Color = FG } })
          table.insert(elements, { Text = ' ' .. seg .. ' ' })
        end
        window:set_right_status(wezterm.format(elements))
      end)

      return config
    '';
  };
}

{inputs, ...}: {
  imports = [inputs.nvf.homeManagerModules.default];
  programs.nvf = {
    enable = true;
    # nvf's own knob — sets EDITOR/VISUAL to nvim for the whole session
    # (programs.neovim.defaultEditor is a no-op here: that module is disabled)
    defaultEditor = true;
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };
        statusline.lualine.enable = true;
        tabline.nvimBufferline.enable = true; # open buffers as tabs along the top
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        lsp = {
          enable = true;
          trouble.enable = true; # pretty diagnostics panel (<leader>ld / <leader>lwd)
          lspkind = {
            enable = true; # VSCode-style icons in the completion menu
            setupOpts.mode = "symbol_text";
          };
        };

        # pops up a cheat-sheet of keybinds when you pause mid-chord
        binds.whichKey.enable = true;
        autopairs.nvim-autopairs.enable = true;

        # greeter screen on bare `nvim` — recent files + shortcuts
        dashboard.alpha = {
          enable = true;
          theme = "theta";
        };

        ui = {
          noice.enable = true; # floating cmdline + message routing, the big visual upgrade
          illuminate.enable = true; # highlight other uses of the word under cursor
          colorizer = {
            enable = true; # show #b8bb26 in its actual color while editing themes
            setupOpts.user_default_options = {
              names = false; # don't colorize prose words like "red"
              css = true;
              mode = "background";
            };
          };
          smartcolumn = {
            enable = true; # line-length guide that only appears when a line crosses it
            setupOpts.colorcolumn = "120";
          };
        };

        visuals = {
          indent-blankline.enable = true; # thin scope-aware indent guides
          nvim-cursorline = {
            enable = true;
            setupOpts.cursorline = {
              enable = true;
              timeout = 0;
              number = true;
            };
          };
          fidget-nvim.enable = true; # unobtrusive LSP progress spinner
        };

        # pin the enclosing function/class signature while scrolling
        treesitter.context = {
          enable = true;
          setupOpts = {
            max_lines = 3;
            mode = "cursor";
          };
        };

        utility.surround = {
          enable = true;
          useVendoredKeybindings = false; # canonical ys/cs/ds, like every tutorial
        };
        comments.comment-nvim.enable = true; # gcc / gc to toggle comments
        notes.todo-comments.enable = true; # highlight + search TODO/FIXME/HACK

        options = {
          mouse = "a";
          tabstop = 2;
          shiftwidth = 2;
          expandtab = true;
          ignorecase = true;
          smartcase = true;
          scrolloff = 8;
          undofile = true; # undo survives closing the file
        };

        # yank/paste goes through the GNOME Wayland clipboard (wl-clipboard)
        clipboard = {
          enable = true;
          registers = "unnamedplus";
          providers.wl-copy.enable = true;
        };

        # the plugins bring their own leader-based binds (leader = Space, see
        # README); these fill the everyday gaps. which-key shows all of them.
        # Splits deliberately rhyme with wezterm: ALT+Enter/s/w on the terminal
        # layer = Space+Enter/s/w on the editor layer.
        keymaps = [
          {
            key = "jk";
            mode = "i";
            action = "<Esc>";
            desc = "Escape without the corner-key trek";
          }
          {
            key = "<leader><CR>";
            mode = "n";
            action = ":vsplit<CR>";
            desc = "Split right";
          }
          {
            key = "<leader>s";
            mode = "n";
            action = ":split<CR>";
            desc = "Split down";
          }
          {
            key = "<leader>w";
            mode = "n";
            action = ":close<CR>";
            desc = "Close split";
          }
          {
            key = "<C-h>";
            mode = "n";
            action = "<C-w>h";
            desc = "Focus split left";
          }
          {
            key = "<C-j>";
            mode = "n";
            action = "<C-w>j";
            desc = "Focus split below";
          }
          {
            key = "<C-k>";
            mode = "n";
            action = "<C-w>k";
            desc = "Focus split above";
          }
          {
            key = "<C-l>";
            mode = "n";
            action = "<C-w>l";
            desc = "Focus split right";
          }
          {
            key = "<C-s>";
            mode = "n";
            action = ":w<CR>";
            desc = "Save file";
          }
          {
            key = "<C-s>";
            mode = "i";
            action = "<Esc>:w<CR>";
            desc = "Save file";
          }
          {
            key = "<Esc>";
            mode = "n";
            action = ":nohlsearch<CR>";
            desc = "Clear search highlight";
          }
          # note: Tab in normal mode == Ctrl-I, so the jump-forward motion is
          # sacrificed for one-key buffer switching — the friendlier trade
          {
            key = "<Tab>";
            mode = "n";
            action = ":BufferLineCycleNext<CR>";
            desc = "Next buffer";
          }
          {
            key = "<S-Tab>";
            mode = "n";
            action = ":BufferLineCyclePrev<CR>";
            desc = "Previous buffer";
          }
          {
            key = "<leader>q";
            mode = "n";
            action = ":bdelete<CR>";
            desc = "Close buffer";
          }
        ];
        languages = {
          enableTreesitter = true;
          enableDAP = true;
          enableFormat = true;
          nix.enable = true;
          rust.enable = true;
          python.enable = true;
          markdown.enable = true;
          bash.enable = true;
          clang.enable = true;
        };
        git.enable = true;
        filetree.nvimTree.enable = true;
        terminal.toggleterm = {
          enable = true;
          lazygit.enable = true;
          setupOpts = {
            enable_winbar = true;
            direction = "float";
          };
        };
      };
    };
  };
}

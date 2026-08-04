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
        lsp.enable = true;

        # pops up a cheat-sheet of keybinds when you pause mid-chord
        binds.whichKey.enable = true;
        autopairs.nvim-autopairs.enable = true;

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
        keymaps = [
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

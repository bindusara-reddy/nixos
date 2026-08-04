{
  # `ff` — minimal nerd-font layout, gruvbox-yellow keys
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_small";
        color = {
          "1" = "blue";
          "2" = "cyan";
        };
        padding = {
          top = 1;
          right = 4;
        };
      };
      display = {
        separator = " ";
        color.keys = "yellow";
      };
      modules = [
        "break"
        {
          type = "title";
          format = "{user-name}@{host-name}";
        }
        "break"
        {
          type = "os";
          key = " ";
          format = "{pretty-name}";
        }
        {
          type = "kernel";
          key = " ";
        }
        {
          type = "wm";
          key = " ";
        }
        {
          type = "terminal";
          key = " ";
        }
        {
          type = "shell";
          key = " ";
        }
        {
          type = "cpu";
          key = " ";
        }
        {
          type = "gpu";
          key = "󰢮 ";
        }
        {
          type = "memory";
          key = " ";
        }
        {
          type = "disk";
          key = "󰋊 ";
        }
        {
          type = "uptime";
          key = "󰅐 ";
        }
        "break"
        "colors"
      ];
    };
  };
}

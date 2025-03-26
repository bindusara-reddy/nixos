{ pkgs, lib, config, ... }: {
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-left = [ 
          "custom/logo" 
          "clock"  
          "disk" 
          "memory"
          "cpu"
          "temperature"
          "hyprland/window" 
        ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [
          "tray"
          "custom/clipboard"
          "backlight"
          "idle_inhibitor"
          "bluetooth"
          "pulseaudio"
          "network"
          "battery"
          "custom/exit" 
        ];

        "custom/logo" = {
          format = "";
          tooltip = false;
        };

        "hyprland/workspaces" = {
	        format = "{icon}";
	        format-icons = {
		        "1" = "";
		        "2" = "";
		        "3" = "";
		        "4" = "";
		        "5" = "";
		        "6" = "";
		        active = "";
		        default = "";
 	        };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          persistent-workspaces = {
            "*" =  [ 2 3 4 5 6 ];
          };
        };

        "idle_inhibitor" = {
          format =  "<span font='12'>{icon} </span>";
          format-icons = {
            activated = "󰈈";
            deactivated = "󰈉";
          };
        };

        "custom/clipboard" = {
          format = "";
          on-click = "cliphist list | rofi -dmenu | cliphist decode | wl-copy";
          interval = 86400;
        };
      
        "clock" = {
          format = "  {:L%I:%M:%S %p}";
          interval = 1;
          tooltip-format = "\n<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          calendar-weeks-pos = "right";
          today-format = "<span color='#7645AD'><b><u>{}</u></b></span>";
          format-calendar = "<span color='#aeaeae'><b>{}</b></span>";
          format-calendar-weeks = "<span color='#aeaeae'><b>W{:%V}</b></span>";
          format-calendar-weekdays = "<span color='#aeaeae'><b>{}</b></span>";
        };

        "bluetooth" = {
          format-on = "";
          format-off = "";
          format-disabled = "󰂲";
          format-connected = "󰂴";
          format-connected-battery = "{device_battery_percentage}% 󰂴";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "blueman";
        };

        "network" = {
          format-wifi = " ";
          format-ethernet = " ";
          format-disconnected = "";
          tooltip-format = "{ipaddr}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)  | {ipaddr}";
          tooltip-format-ethernet = "{ifname} 🖧 | {ipaddr}";
          on-click = "nm-applet";
        };

        "battery" = {
          interval = 1;
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{capacity}%  {icon} ";
          format-charging = "{capacity}% 󰂄 ";
          format-plugged = "{capacity}% 󰂄 ";
          format-alt = "{time} {icon}";
          format-icons = [
            "󰁻"
            "󰁼"
            "󰁾"
            "󰂀"
            "󰂂"
            "󰁹"
          ];
        };
        "backlight" = {
          device = "intel_backlight";
          format = "<span font='12'>{icon}</span>";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
          on-scroll-down = "light -A 10";
          on-scroll-up = "light -U 10";
          smooth-scrolling-threshold = 1;
        };

        "disk" = {
          interval = 30;
          format = "  {percentage_used}%";
          path = "/";
        };

        "cpu" = {
          interval = 1;
          format = " {usage}%";
          min-length = 6;
          max-length = 6;
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
        };

        "memory" = {
          format = " {percentage}%";
        };

        "hyprland/window" = {
          format = "( {class} )";
          rewrite = {
            "(.*) - Mozilla Firefox" = " $1";
            "(.*) - nu" = "> [$1]";
          };
        };

        "temperature" = {
          format = " {temperatureC}°C";           
          format-critical = " {temperatureC}°C";
          interval = 1;
          critical-threshold = 80;
          on-click = "wezterm btop";
        };

        "pulseaudio" = {
          format = "{volume}% {icon}";
          format-bluetooth = "󰂰";
          format-muted = "<span font='12'></span>";
          format-icons = {
            headphones = "";
            bluetooth = "󰥰";
            handsfree = "";
            headset = "󱡬";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
          tooltip-format = "{icon}  {volume}%";
          on-scroll-up = "pamixer -i 5";
          on-scroll-down = "pamixer -d 5";
        };

        "tray" = {
          icon-size = 14;
          spacing = 10;
        };
      }
    ];
  };
}

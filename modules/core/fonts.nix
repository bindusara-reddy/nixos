{pkgs, ...}: {
  # Without these the starship glyphs and wezterm's "JetBrains Mono" silently
  # fall back to whatever fontconfig finds. Now they actually exist.
  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
    fontconfig.defaultFonts = {
      monospace = ["JetBrainsMono Nerd Font"];
      emoji = ["Noto Color Emoji"];
    };
  };
}

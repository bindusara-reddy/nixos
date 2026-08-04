{pkgs, ...}: {
  # Without these the starship glyphs and wezterm's "JetBrains Mono" silently
  # fall back to whatever fontconfig finds. Now they actually exist.
  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
    ];
    # …and make them the generic-family answers too, or fontconfig keeps
    # handing out DejaVu for sans/serif despite all the Noto above
    fontconfig.defaultFonts = {
      monospace = ["JetBrainsMono Nerd Font"];
      sansSerif = ["Noto Sans" "Noto Sans CJK SC"];
      serif = ["Noto Serif" "Noto Serif CJK SC"];
      emoji = ["Noto Color Emoji"];
    };
  };
}

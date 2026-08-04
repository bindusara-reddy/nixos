{
  # shell history that doesn't suck: Ctrl-R gives fuzzy search over every
  # command you've ever run, with context. Local only (no sync account).
  programs.atuin = {
    enable = true;
    enableNushellIntegration = true;
    flags = ["--disable-up-arrow"]; # keep normal up-arrow; Ctrl-R for the good stuff
    settings = {
      enter_accept = true;
      inline_height = 20;
    };
  };
}

{
  programs.firefox = {
    enable = true;
    # keep the classic profile location — the existing profile already lives there
    configPath = ".mozilla/firefox";
  };

  # chrome registers itself as the URL handler on first run — firefox is the
  # default browser on this machine, declaratively, and stays that way
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "text/html" = "firefox.desktop";
    };
  };
}

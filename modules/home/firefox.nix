{
  programs.firefox = {
    enable = true;
    # keep the classic profile location — the existing profile already lives there
    configPath = ".mozilla/firefox";
  };
}

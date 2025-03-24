{
  programs.nushell = {
    enable = true;
    shellAliases = {
      ls = "eza";
    };
    settings = {
      show_banner = false;
      completions = {
       	case_sensitive = false;
	      quick = true;
	      partial = true;
	      algorithm = "prefix";
      };
    };
 
  };
}

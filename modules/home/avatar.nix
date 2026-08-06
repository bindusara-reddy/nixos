{
  # The login avatar cosmic-greeter shows comes from AccountsService, and NixOS
  # has no users.users.<name>.icon option to set it. AccountsService falls back
  # to ~/.face when a user has no Icon= of its own, which is the one hook that
  # does not need root or a mutable file under /var/lib -- so home-manager can
  # own it like any other dotfile, and it survives a reinstall.
  #
  # Art is OMOCAT's; kept in-repo because ~/.face lives outside every directory
  # the backup covers, which is exactly how the previous copy got lost.
  home.file.".face".source = ./avatar.png;
}

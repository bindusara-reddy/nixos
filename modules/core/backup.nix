{
  config,
  lib,
  ...
}: {
  # Nightly encrypted restic backup of /home to deepblue over the tailnet.
  # Off until two one-time steps are done (as root, since restic runs as root):
  #   1. put a strong passphrase in /root/restic-password  (chmod 600 — and keep
  #      a copy somewhere off this machine, no passphrase = no restore)
  #   2. give root an ssh key deepblue accepts:
  #        sudo ssh-keygen -t ed25519 -N ""
  #        sudo ssh-copy-id waterfly@100.111.247.29
  # then set `backups = true` in hosts/hal-9000/variables.nix and rebuild.
  #
  # Restore drill: restic -r sftp:waterfly@100.111.247.29:/backups/hal-9000 snapshots
  config = lib.mkIf config.var.backups {
    services.restic.backups.home = {
      initialize = true;
      repository = "sftp:waterfly@100.111.247.29:/backups/hal-9000"; # deepblue
      passwordFile = "/root/restic-password";
      paths = ["/home/${config.var.username}"];
      exclude = [
        "/home/*/.cache"
        "/home/*/.cargo"
        "/home/*/.local/share/Steam"
        "/home/*/.local/share/Trash"
      ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true; # asleep at midnight? runs on next wake instead
      };
      pruneOpts = ["--keep-daily 7" "--keep-weekly 4" "--keep-monthly 6"];
    };
  };
}

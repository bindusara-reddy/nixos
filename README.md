<h1 align="center">:snowflake: Himalaya :snowflake:</h1>
<p align="center">
  <img width="80%" src="https://github.com/user-attachments/assets/1d15cee3-9531-4436-9fc0-7ca9ae86d8bc" />
</p>
<p align="center">NixOS for the MSI Katana GF66 11UE (<code>sal-9000</code>) — i7-11800H · RTX 3060 · GNOME · nushell · nvf</p>

---

## First boot after pulling this repo

```sh
cd ~/nixos   # or wherever the clone lives; clone it to ~/nixos if you haven't
git pull
./bootstrap.sh
```

`bootstrap.sh` syncs the hardware config from the live machine if it drifted, rebuilds,
and commits the updated `flake.lock`. That's it. If you'd rather do it by hand:

```sh
sudo nixos-rebuild switch --flake .#sal-9000
```

After the first successful switch, log out and back in (shell + session changes),
then join the tailnet once:

```sh
sudo tailscale up
```

> **Note:** the first rebuild downloads a few GB (new kernel, fonts, tools). Let it cook.

## Daily driving

| you type  | what happens |
|-----------|--------------|
| `rebuild` | apply the config (`nh os switch` — shows a diff of what changed) |
| `update`  | update all flake inputs **and** rebuild (`nh os switch --update`) |
| `clean`   | delete old generations, keep last 5 / last 7 days |
| `nh search foo` | search nixpkgs from the terminal |
| `,foo`    | run a program once without installing it |
| `nvidia-offload <cmd>` | run something on the RTX 3060 (everything else uses the iGPU) |
| `Ctrl-R`  | fuzzy search your entire shell history (atuin) |
| `y`       | terminal file manager (yazi) |
| `lg`      | lazygit |

**Add a package:** put it in [modules/home/home-packages.nix](modules/home/home-packages.nix)
(user stuff) or [modules/core/host-packages.nix](modules/core/host-packages.nix) (system stuff),
then `rebuild`.

**Something broke after a rebuild?** Reboot and pick the previous generation in the boot
menu — the old system is always still there. From a working shell:
`sudo nixos-rebuild switch --rollback` does the same without rebooting.

## What's where

```
flake.nix                 inputs (nixpkgs unstable, home-manager, rust-overlay, nvf,
                          nix-index-database, hermes-agent)
hosts/sal-9000/
  variables.nix           hostname, username, timezone, GPU bus IDs — the knobs
  configuration.nix       glue + stateVersion (LEAVE ALONE)
  hardware-configuration.nix  generated; bootstrap.sh keeps it synced
modules/core/             system: boot, nvidia, gnome, audio, network, ssh,
                          tailscale, power, fonts, steam, docker, rust, nix itself
modules/home/             your user: nushell, starship, wezterm, nvf (neovim),
                          git, atuin, gnome tweaks, packages, ssh hosts…
```

## The GPU situation (important on this laptop)

Default mode is **offload**: the Intel iGPU drives the screen, the RTX 3060 sleeps
(RTD3) until you run something with `nvidia-offload` or a game from Steam with
`gamemoderun %command%` in its launch options. Great battery, silent fans.

The boot menu also has a **`gaming` specialisation**: the 3060 drives everything
(sync mode). Pick that entry for external monitors/HDMI or long gaming sessions.

## The fleet

`ssh jetson` / `ssh deepblue` — hosts are preconfigured (tailnet IPs).
Copy the private keys from wherever they live into `~/.ssh/` first. This machine also
runs sshd, key-only, reachable **only over tailscale**.

## Extras you might forget exist

- **GSConnect**: pair your phone (KDE Connect app) — notifications, files, clipboard.
- **Flatpak** for anything not in nixpkgs: `flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo` once, then `flatpak install flathub <app>`.
- **LocalSend** for AirDrop-style file drops between all your machines.
- **Firmware updates**: `fwupdmgr refresh && fwupdmgr update`.
- **Backups**: a nightly restic backup of `/home` to deepblue is ready in
  [modules/core/backup.nix](modules/core/backup.nix) — do the two one-time steps
  in its header comment, then set `backups = true` in `variables.nix`.
- `mission-center` (GUI) / `btop` / `nvtop` for watching the machine work.
- AI CLIs preinstalled: `claude`, `codex`, `gemini`, and `hermes` (Nous Research's
  self-improving agent — run `hermes setup` once to pick a provider, then just `hermes`).

## Learning more

- Search options: <https://search.nixos.org/options> · packages: <https://search.nixos.org/packages>
- Home-manager options: <https://nix-community.github.io/home-manager/options.xhtml>
- <https://nix.dev> — the actual good manual

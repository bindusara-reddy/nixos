<h1 align="center">:snowflake: Himalaya :snowflake:</h1>
<p align="center">
  <img width="80%" src="https://github.com/user-attachments/assets/1d15cee3-9531-4436-9fc0-7ca9ae86d8bc" />
</p>
<p align="center">NixOS for the MSI Katana GF66 11UE (<code>hal-9000</code>) — i7-11800H · RTX 3060 · COSMIC · nushell · nvf</p>

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
sudo nixos-rebuild switch --flake .#hal-9000
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

## Keys worth knowing

**WezTerm** — every binding is one <kbd>ALT</kbd>+key, nothing more.
Plain CTRL keys always reach the shell; copy/paste stays <kbd>CTRL+SHIFT+C/V</kbd>.
Resize panes by dragging the divider with the mouse.

| keys | action |
|------|--------|
| `ALT+Enter` | split right |
| `ALT+s` | split down |
| `ALT+arrows` | move between panes |
| `ALT+z` | zoom the current pane (again to unzoom) |
| `ALT+w` | close pane |
| `ALT+t` / `ALT+1…9` | new tab / jump to tab |

**Shell (nushell)** — emacs-style line editing, the keys your fingers already know:
arrows, `Ctrl+A`/`E` start/end, `Ctrl+W` delete word, `Alt+B`/`F` by word.
`Ctrl+R` fuzzy-searches all history (atuin), `Tab` opens an IDE-style completion
menu with descriptions (fuzzy — `nxrb` finds `nixos-rebuild`), `Ctrl+O` edits the
current line in nvim. `cd` is zoxide-powered: `cd proj` jumps to `~/Projects`
from anywhere once visited; `cdi` opens a fuzzy picker. Typo'd a command?
It tells you which nix package has it.

**Neovim** — <kbd>Space</kbd> is the leader (your other thumb, mirroring ALT);
pause after pressing it and which-key shows everything. Splits rhyme with the
terminal: same key, editor layer.

| keys | action |
|------|--------|
| `jk` (insert mode, typed fast) | Escape — no corner-key trek |
| `Space Enter` / `Space s` | split right / split down (same as ALT in wezterm) |
| `Space w` | close split (ALT+w's editor twin) |
| `Ctrl+h j k l` | move between splits |
| `Space ff` / `fg` / `fb` | find files / grep project / open buffers (telescope) |
| `Space t` | file tree |
| `Space gg` | lazygit, floating |
| `Ctrl+t` | floating terminal |
| `Tab` / `Shift+Tab` | next / previous buffer |
| `Space q` | close buffer |
| `Ctrl+s` | save |

**Add a package:** put it in [modules/home/home-packages.nix](modules/home/home-packages.nix)
(user stuff) or [modules/core/host-packages.nix](modules/core/host-packages.nix) (system stuff),
then `rebuild`.

**Something broke after a rebuild?** Normally you'd reboot and pick the previous
generation, but the profile was deliberately collapsed to a single generation
(numbered 1) after the 2026-08 reinstall — **there is nothing to roll back to**
until you've built a few more. `--rollback` will fail, and the boot menu has one
entry. Recover by fixing the config and rebuilding, or from the Ubuntu image on
the USB stick (mount `/dev/disk/by-label/nixos`, chroot, rebuild) — the NixOS
installer was wiped off that stick.

Once you have several generations again, the old advice applies:
`sudo nixos-rebuild switch --rollback`, or pick an older entry at boot.

## What's where

```
flake.nix                 inputs (nixpkgs unstable, home-manager, rust-overlay, nvf,
                          nix-index-database, hermes-agent)
hosts/hal-9000/
  variables.nix           hostname, username, timezone, GPU bus IDs — the knobs
  configuration.nix       glue + stateVersion (LEAVE ALONE)
  hardware-configuration.nix  generated; bootstrap.sh keeps it synced
modules/core/             system: boot, nvidia, cosmic, audio, network, ssh,
                          tailscale, power, fonts, steam, docker, rust, nix itself
modules/home/             your user: nushell, starship, wezterm, nvf (neovim),
                          git, atuin, cosmic settings, packages, login avatar…
```

## The GPU situation (important on this laptop)

Default mode is **offload**: the Intel iGPU drives the screen, the RTX 3060 sleeps
(RTD3) until you run something with `nvidia-offload` or a game from Steam with
`gamemoderun %command%` in its launch options. Great battery, silent fans.

If you ever need the 3060 to drive everything all the time (external monitors/HDMI
are wired to it), resurrect the `gaming` specialisation from git history (it was
removed in favor of a single boot entry — see the commit that touched this line).

## The fleet

Currently a fleet of one. `deepblue` and the jetson left the tailnet in 2026-08 and
their keys were destroyed with them, so the per-host `ssh` blocks that pointed at
`100.x` addresses are gone from [modules/home/ssh.nix](modules/home/ssh.nix) — add
them back there if either machine rejoins. Only `~/.ssh/id_ed25519` (GitHub) remains.

This machine runs sshd, key-only, reachable **only over tailscale** (`hal-9000`).

`deepblue` still runs Sunshine, and Moonlight reaches it over plain LAN via mDNS —
no tailnet needed. `moonlight` finds `deep-blue.local` on its own; pair once with
`moonlight pair <ip> --pin 1234`, entering the same PIN in Sunshine's web UI on
port 47990.

## Extras you might forget exist

- **Flatpak** for anything not in nixpkgs: `flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo` once, then `flatpak install flathub <app>`.
- **LocalSend** for AirDrop-style file drops between all your machines.
- **Firmware updates**: `fwupdmgr refresh && fwupdmgr update`.
- **Login avatar** lives in [modules/home/avatar.nix](modules/home/avatar.nix) as
  `~/.face`. NixOS has no `users.users.<name>.icon`, but AccountsService — what
  cosmic-greeter reads — falls back to `~/.face`, so home-manager can own it with
  no root and no mutable state under `/var/lib`. Check it took with
  `busctl --system get-property org.freedesktop.Accounts /org/freedesktop/Accounts/User1000 org.freedesktop.Accounts.User IconFile`.
- `mission-center` (GUI) / `btop` (with GPU panel) for watching the machine work.
- AI CLIs preinstalled: `claude`, `codex`, `gemini`, and `hermes` (Nous Research's
  self-improving agent — run `hermes setup` once to pick a provider, then just `hermes`).

## Learning more

- Search options: <https://search.nixos.org/options> · packages: <https://search.nixos.org/packages>
- Home-manager options: <https://nix-community.github.io/home-manager/options.xhtml>
- <https://nix.dev> — the actual good manual

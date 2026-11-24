# ❄️ NixOS Configuration

> Personal, modular and declarative NixOS configuration built around Flakes, Home Manager and a Hyprland-based desktop environment.

![NixOS](https://img.shields.io/badge/NixOS-25.05-5277C3?style=for-the-badge\&logo=nixos\&logoColor=white)
![Nix](https://img.shields.io/badge/Nix-Flakes-5277C3?style=for-the-badge\&logo=nixos\&logoColor=white)
![Hyprland](https://img.shields.io/badge/WM-Hyprland-00A3CC?style=for-the-badge\&logo=hyprland\&logoColor=white)
![Home Manager](https://img.shields.io/badge/Home%20Manager-Declarative-7E7E7E?style=for-the-badge)

This repository contains my personal **NixOS system configuration**.

The system is managed declaratively using **Nix**, **Nix Flakes**, and **Home Manager**, with desktop and development configuration split into reusable modules.

It is primarily intended as a record of my own system and as a reference for experimenting with reproducible Linux configuration.

---

## ✨ Highlights

* ❄️ Declarative **NixOS** configuration
* 🧩 Modular configuration using separate `.nix` modules
* 📦 **Nix Flakes** for dependency and system configuration management
* 🏠 **Home Manager** for user-level configuration
* 🪟 **Hyprland** Wayland compositor
* 📝 **Neovim** development environment
* 💻 **VS Code** development environment
* 🐚 **Zsh** with completions, autosuggestions and syntax highlighting
* 📊 **Waybar**
* 🚀 **Starship**
* 🖥️ **Alacritty**
* 🔎 **Rofi**
* 🔔 **Dunst**
* 🦀 Rust development environment
* 🔧 Git configuration
* 🎨 Catppuccin-based desktop theming
* 🎵 Spotify integration
* 🔊 PipeWire audio
* 🟦 Bluetooth support
* 🔐 GNOME Keyring / Secret Service integration
* ♻️ Automatic system upgrades and Nix garbage collection

---

# 🏗️ Architecture

The configuration is divided into two main layers:

```text
                    NixOS
                      │
          ┌───────────┴───────────┐
          │                       │
 configuration.nix             Home Manager
          │                       │
   System services          User environment
   Hardware / boot          Applications
   Networking               Dotfiles
   Audio / Bluetooth        Development tools
          │                       │
          └───────────┬───────────┘
                      │
                    Flake
                      │
              Reproducible setup
```

The system configuration handles OS-level functionality, while Home Manager manages the user's environment and desktop applications.

---

# 📂 Repository Structure

```text
.
├── Other/
│
├── modules/
│   ├── alacritty.nix
│   ├── dunst.nix
│   ├── git.nix
│   ├── hyprland.nix
│   ├── neovim.nix
│   ├── rofi.nix
│   ├── rust.nix
│   ├── sh.nix
│   ├── starhip.nix
│   ├── vscode.nix
│   └── waybar.nix
│
├── configuration.nix
├── hardware-configuration.nix
├── home.nix
├── flake.nix
├── flake.lock
└── README.md
```

The modular layout keeps individual pieces of the user environment isolated,
making the configuration easier to understand and modify.

---

# ❄️ Nix Flakes

The repository uses Nix Flakes as the main entry point for the configuration.

The current flake defines:

```nix
nixosConfigurations
homeConfigurations
```

The NixOS configuration targets:

```text
x86_64-linux
```

and uses:

* `nixpkgs`
* `home-manager`

as flake inputs.

The system currently tracks the NixOS **unstable** channel through:

```nix
github:nixos/nixpkgs/nixos-unstable
```

while Home Manager follows the same `nixpkgs` input.

This keeps system and user-level configuration tied to a consistent package set.

---

# 🧩 Modular Configuration

Most desktop and development applications are defined as dedicated modules.

### Desktop

```text
Hyprland
Waybar
Rofi
Alacritty
Dunst
Starship
```

### Development

```text
Neovim
VS Code
Git
Rust
```

### Shell

```text
Zsh
Shell utilities
Completion
Autosuggestions
Syntax highlighting
```

This structure makes it possible to modify one part of the environment without having to maintain a single large configuration file.

---

# 🪟 Hyprland

The desktop environment is based around **Hyprland**, running on Wayland.

The system enables Hyprland with XWayland support and configures the surrounding Wayland desktop stack through dedicated Home Manager modules.

The setup is designed around:

* keyboard-driven workflows
* workspaces
* terminal-based development
* minimal desktop overhead
* fast application launching
* customizable visual theming

---

# 🏠 Home Manager

Home Manager is used to manage the user environment declaratively.

The current configuration includes modules for:

```text
Hyprland
Waybar
Alacritty
Neovim
VS Code
Rofi
Dunst
Git
Zsh
Starship
Rust
```

User-level packages and environment variables are also managed through Home Manager.

Examples include:

```text
Brave
Git
curl
wget
unzip
Spotify
Nerd Fonts
```

and environment configuration such as:

```text
GTK_THEME=Catppuccin-Mocha
TERMINAL=alacritty
```

---

# 🐚 Shell Environment

The system uses **Zsh** as the default shell.

Enabled shell functionality includes:

* command completion
* autosuggestions
* syntax highlighting
* shell utilities
* Starship prompt

The shell is configured declaratively at the NixOS level while user-specific configuration is managed through Home Manager.

---

# 📝 Neovim

Neovim is part of the development environment and is managed through a dedicated module.

The goal is to keep the editor reproducible as part of the system configuration instead of treating it as an unmanaged standalone installation.

This allows editor configuration to evolve together with the rest of the development environment.

---

# 🎨 Theming

The desktop follows a dark, Catppuccin-inspired visual style.

The theme is propagated across applications where possible, including:

```text
GTK
Terminal
Desktop applications
Wayland environment
```

The configuration also includes Nerd Fonts and additional font packages for terminal and status-bar rendering.

---

# 🔊 System Services

The system configuration also manages a number of low-level and desktop services.

### Audio

PipeWire is enabled with:

```text
ALSA
32-bit ALSA support
PulseAudio compatibility
WirePlumber
```

### Bluetooth

Bluetooth is enabled at boot with BlueZ and Blueman.

### Authentication / Secrets

The system integrates:

```text
Polkit
GNOME Keyring
libsecret
```

for authentication and secret management.

### Networking

NetworkManager is enabled as the main networking backend.

---

# ♻️ Maintenance

The configuration includes automated NixOS maintenance.

### Automatic updates

System upgrades are scheduled weekly.

### Garbage collection

Nix garbage collection runs automatically and removes generations older than:

```text
10 days
```

The Nix store is also configured for automatic optimisation.

This keeps the system from accumulating unnecessary generations and store data indefinitely.

---

# 🚀 Applying the Configuration

After adapting the configuration to your own machine, a typical workflow is:

```bash
sudo nixos-rebuild switch --flake .#Nixos-JRJ-BRW
```

For a boot-only deployment:

```bash
sudo nixos-rebuild boot --flake .#Nixos-JRJ-BRW
```

For Home Manager:

```bash
home-manager switch --flake .#jorj
```

The exact commands may need to be adjusted depending on how the configuration is installed and how the local NixOS environment is set up.

---

# ⚠️ Important: This Is a Personal Configuration

This repository is **not intended to be a plug-and-play NixOS installer**.

It contains machine-specific and user-specific configuration.

In particular, `hardware-configuration.nix` is generated for the target machine and should **not** simply be copied to another computer.

Before deploying the configuration on a different system, generate a new hardware configuration using NixOS and adapt the system-specific settings accordingly.

The existing `flake.lock` is also tied to the state of the inputs used by this configuration. When adapting the repository to another setup, it may need to be regenerated.

> **Do not blindly apply this repository to your system without reviewing the configuration first.**

---

# 🛠️ Customization

The intended way to customize the environment is to modify or add modules under:

```text
modules/
```

For example:

```text
modules/neovim.nix
modules/hyprland.nix
modules/waybar.nix
```

This makes it possible to keep application configuration isolated and maintainable.

A new application can generally be introduced as its own Nix module rather than expanding one large configuration file.

---

# 🧠 Why NixOS?

This configuration is part of my exploration of declarative system management and reproducible development environments.

Instead of manually installing and configuring every application, the goal is to describe the desired state of the system as code.

That provides a workflow closer to software development:

```text
Configuration
      ↓
   Evaluation
      ↓
    Build
      ↓
   Activate
      ↓
 Reproducible system
```

This repository therefore serves both as my daily-driver configuration and as a practical way to learn:

* Nix
* NixOS
* functional/declarative configuration
* Linux system administration
* reproducible environments
* modular configuration design
* development tooling
* Wayland desktop configuration

---

# 📸 Desktop

The repository currently includes screenshots of the configured desktop environment.

The setup combines:

* Hyprland
* Waybar
* Alacritty
* Rofi
* Catppuccin-inspired theming
* terminal-oriented development workflow

---

# 🚧 Status

**Personal / actively evolving**

This configuration changes as I experiment with new tools, improve my workflow, learn more about NixOS, and refine the desktop environment.

Expect breaking changes, machine-specific assumptions, and experimentation.

---

## 🔗 Related

My Arch Linux configuration:

**Dotfiles.Arch**
https://github.com/TG-Jorj-2005/Dotfiles.Arch

---

## 📜 License

This repository represents my personal configuration and is primarily intended for reference and personal use.

Check individual files and dependencies for their respective licensing requirements.


<img width="1921" height="1080" alt="image" src="https://github.com/user-attachments/assets/93185945-233f-449c-8f1c-3ecade0e96d4" />

<img width="1921" height="1081" alt="image" src="https://github.com/user-attachments/assets/deee5ab3-77a1-4ea3-815f-9851b04aa29a" />

<img width="1917" height="1081" alt="image" src="https://github.com/user-attachments/assets/dd9a8dbe-ad38-4bab-bbc3-1e50e305689f" />


# Dotfiles

A centralized repository for managing and deploying configuration files on a new Linux installation.

## Structure
- `.config/i3/`: Configurations for the i3 window manager, including a custom multi-monitor workspace script.
- `.config/i3status/`: Configuration for the i3status status bar.
- `setup.sh`: A helper bash script to automatically and safely symlink configuration directories into your `$HOME/.config` folder.

## Installation / Setup

When setting up your new Linux machine, clone this repository and run the setup script:

```bash
# Clone the repository
git clone <your-repo-url> ~/dotfiles

# Change into the directory
cd ~/dotfiles

# Run the setup script
./setup.sh
```

### What the `setup.sh` script does:
1. Automatically creates any necessary parent directories in your `$HOME` folder.
2. Symlinks both nested configurations (e.g., `.config/i3`) and home-root configurations (e.g., `.bashrc`, `.prettierrc`) to their respective destinations.
3. Gracefully skips any configurations listed in the script that do not yet exist in your repository.
4. Safely backs up any existing directory, file, or conflicting symlink pointing elsewhere with a `.backup` suffix (e.g., `~/.config/i3.backup` or `~/.bashrc.backup`) to prevent any data loss.

---

## Dependencies

Before running i3 with these configurations, ensure the following dependencies are installed on your Linux machine:

### System Packages
Depending on your Linux distribution, install `i3`, `i3status`, and `python3`:

- **Arch Linux:**
  ```bash
  sudo pacman -S i3-wm i3status python
  ```
- **Ubuntu/Debian:**
  ```bash
  sudo apt update
  sudo apt install i3 i3status python3
  ```

### Python Dependencies
The i3 configuration utilizes a custom script (`smart_workspace.py`) to manage multi-monitor workspace layout offsets dynamically. It requires the `i3ipc` library:

```bash
# Install via pip
pip install i3ipc
```
*(Or install via your package manager if preferred, e.g., `sudo apt install python3-i3ipc` or `sudo pacman -S python-i3ipc`)*

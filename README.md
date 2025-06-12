# Custom Caja File Manager with Dock Integration

This repository contains scripts and resources to:

- Replace **Nautilus** with **Caja** as the default file manager on Ubuntu.
- Use a **custom icon** for Caja in the GNOME Dock.
- Avoid **duplicate icons** when launching Caja from the dock.

## 🗂️ Structure

- `resources/` — Contains the custom icons used.
- `sh-scripts/` — Contains Linux shell scripts with all steps commented.

## 🧩 Features

- Sets Caja as the default file manager (`xdg-open .`)
- Adds a custom icon to the GNOME dock for Caja
- Ensures that clicking the dock icon opens the existing window (no duplicates)
- Handles GNOME's StartupWMClass binding

## 🔧 Requirements

- Ubuntu 22.04 or later
- Caja
- GNOME Shell
- xprop

## 📦🐧 Installation

1. Clone this repository:

```
git clone https://github.com/rafaeltenoriogama/caja-file-manager.git
```

2. See the scripts inside the `shell_scripts` directory. You may run them manually step-by-step to better understand what each part does.

3. Manually pin Caja from the App Menu to your dock, then remove the default "Files" (Nautilus) icon.

4. Voila! A penguin icon in your dock along with Caja as file manager.

## 🐧 Credits

Hope you all like it, this is for fun aesthetic proposes of an idea that came from a coffee in a regular aternoon. Feel free to contribute.

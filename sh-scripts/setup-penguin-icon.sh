#!/bin/bash
# This script customizes the Caja .desktop entry to use a custom icon
# and prevents GNOME from creating a duplicated icon in the dock.

echo "🔧 Creating local applications folder if it doesn't exist..."
mkdir -p ~/.local/share/applications

echo "📄 Copying Caja's desktop entry to local user directory..."
cp /usr/share/applications/caja.desktop ~/.local/share/applications/

echo "🖼️ Replacing the default icon with the custom one..."
# Make sure the icon exists before continuing
CUSTOM_ICON_PATH="$HOME/.local/share/icons/caja-custom.png"

if [ ! -f "$CUSTOM_ICON_PATH" ]; then
  echo "❌ Custom icon not found at $CUSTOM_ICON_PATH"
  echo "Please place your icon at that location before running this script."
  exit 1
fi

# Replace the Icon line with the full path to the custom icon
sed -i "s|^Icon=.*|Icon=$CUSTOM_ICON_PATH|" ~/.local/share/applications/caja.desktop

echo "🧠 Ensuring proper window class to avoid icon duplication..."
# Add StartupWMClass=Caja if it's not already present
grep -q '^StartupWMClass=' ~/.local/share/applications/caja.desktop &&
  sed -i "s|^StartupWMClass=.*|StartupWMClass=Caja|" ~/.local/share/applications/caja.desktop ||
  echo "StartupWMClass=Caja" >>~/.local/share/applications/caja.desktop

echo "🔐 Marking the .desktop file as trusted..."
gio set ~/.local/share/applications/caja.desktop metadata::trusted true

echo "🔁 Updating desktop database..."
update-desktop-database ~/.local/share/applications

echo "✅ Done! Search for 'Caja' in your app menu and pin it to the dock."
echo "ℹ️ Then remove the default 'Files' icon (Nautilus) from the dock if it's still there."

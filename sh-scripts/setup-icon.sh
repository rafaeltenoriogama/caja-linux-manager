#!/bin/bash
# This script customizes Caja's desktop entry to use a custom icon
# and prevents duplicate icons in the GNOME Dock.

echo "🔧 Creating local applications and icons directories..."
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/icons

echo "📄 Copying Caja's desktop entry to your user directory..."
cp /usr/share/applications/caja.desktop ~/.local/share/applications/

# Ask user for icon path
echo "📥 Please enter the full path to the caja-custom.png icon."
echo "💡 Tip: it's likely inside the 'resources/' folder of this repository."
read -rp "🖼️ Icon path: " USER_ICON_PATH

# Check if the file exists
if [ ! -f "$USER_ICON_PATH" ]; then
  echo "❌ The file does not exist: $USER_ICON_PATH"
  echo "Please make sure you entered the correct path to caja-custom.png."
  exit 1
fi

# Copy to expected destination
CUSTOM_ICON_PATH="$HOME/.local/share/icons/caja-custom.png"
cp "$USER_ICON_PATH" "$CUSTOM_ICON_PATH"

echo "🖼️ Updating the .desktop file to use the custom icon..."
sed -i "s|^Icon=.*|Icon=$CUSTOM_ICON_PATH|" ~/.local/share/applications/caja.desktop

echo "🧠 Ensuring proper window matching with StartupWMClass..."
grep -q '^StartupWMClass=' ~/.local/share/applications/caja.desktop &&
  sed -i "s|^StartupWMClass=.*|StartupWMClass=Caja|" ~/.local/share/applications/caja.desktop ||
  echo "StartupWMClass=Caja" >>~/.local/share/applications/caja.desktop

echo "🔐 Trusting the custom .desktop entry..."
gio set ~/.local/share/applications/caja.desktop metadata::trusted true

echo "🔁 Refreshing desktop entry database..."
update-desktop-database ~/.local/share/applications

echo "✅ All set!"
echo "👉 Search for 'Caja' in your app menu and pin it to the dock."
echo "🧹 Then remove the default 'Files' (Nautilus) icon if it's still pinned."

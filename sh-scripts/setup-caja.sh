#!/bin/bash
# This script sets Caja as the default file manager in Ubuntu
# and ensures that it opens folders when using xdg-open or clicking on directories.

echo "🔧 Installing Caja file manager..."
sudo apt update
sudo apt install -y caja

echo "🔧 Setting Caja as the default file manager..."

# Set Caja as the default handler for folders
xdg-mime default caja.desktop inode/directory application/x-gnome-saved-search

echo "✅ Caja is now the default file manager for folders."

echo "🔇 Now we'll create a silent wrapper to prevent log messages when using 'xdg-open .'"

# Prompt for username to build correct Exec path
echo "👤 Please enter your Linux username (the one in /home/your-username):"
read -rp "Username: " USERNAME

# Prepare directories
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/applications

# Create the silent launcher script
SILENT_SCRIPT="$HOME/.local/bin/caja-silent"
cat <<EOF >"$SILENT_SCRIPT"
#!/bin/bash
caja "\$@" >/dev/null 2>&1 &
disown
EOF

chmod +x "$SILENT_SCRIPT"

# Create the .desktop entry for xdg-open to use without showing output
SILENT_DESKTOP="$HOME/.local/share/applications/caja-silent.desktop"
cat <<EOF >"$SILENT_DESKTOP"
[Desktop Entry]
Name=Caja (Silent)
Exec=/home/$USERNAME/.local/bin/caja-silent %U
Terminal=false
Type=Application
MimeType=inode/directory;application/x-gnome-saved-search;
NoDisplay=true
EOF

gio set "$SILENT_DESKTOP" metadata::trusted true

echo "✅ Silent launcher created."
echo "ℹ️ To use it with 'xdg-open', you can now set:"
echo "   xdg-mime default caja-silent.desktop inode/directory application/x-gnome-saved-search"

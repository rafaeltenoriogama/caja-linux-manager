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

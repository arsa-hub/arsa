
Debian
====================
This directory contains files used to package arsad/arsa-qt
for Debian-based Linux systems. If you compile arsad/arsa-qt yourself, there are some useful files here.

## arsa: URI support ##


arsa-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install arsa-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your arsa-qt binary to `/usr/bin`
and the `../../share/pixmaps/arsa128.png` to `/usr/share/pixmaps`

arsa-qt.protocol (KDE)


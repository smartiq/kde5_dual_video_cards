KDE5 Dual Video Cards
===========

I have been trying to get my computer, which features dual GTX 980 video
cards to correctly display in KDE5.  Unfortunately, that progress has been
hampered slightly by the following KDE bugs:
* https://bugs.kde.org/show_bug.cgi?id=352462
* https://bugs.kde.org/show_bug.cgi?id=343844

I have tried a lot of various configurations:
1) Using xf86-video-nouveau doesn't support the NV124 (yet) so it doesn't work
2) Using modesetting/KMS driver single single card works but I hang at login much like KDE bug 343844
3) Using modesetting/KMS driver with dual cards causes Xorg to segfault on a call to OsLookupColor+0x139 (still investigating this one)
4) Using nvidia driver with dual cards hits bug 343844

As of 9/12/15, I have two working configurations
1) Single card with nvidia driver works (nvidia-settings -> configure one card only)
2) Dual cards with nvidia driver and Xinerama turned off works (two separate display servers)

This repository has patches that I am testing with ArchLinux to try to make my
system work with both video cards as part of the same display.  The packages
directory features package scripts that can be used with
[makepkg](https://wiki.archlinux.org/index.php/Makepkg) and the
debug_scripts directory features debug script and output to capture
the state of the system.


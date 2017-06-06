CobraOS
=======

A live-media-oriented operating system for Epitech Lyon's Coding Club.

This is based on the Archiso tools. This repository has an heavy dependency chain, so you will not be able to build on a distribution other than ArchLinux, derivatives untested.

These scripts use the Archiso suite of tools, as well as ArchLinux installation scripts, both of which **heavily** depend on `pacman`, ArchLinux's package manager. These scripts may be used from an older version of the ISO.

Building an ISO
---------------

It's pretty simple, once you've installed `archiso` with:
```bash
sudo pacman -Syu archiso
```
You just need to run `build.sh` as root:
```bash
sudo ./build.sh
```
The ISO will be generated, the process takes a while, especially on slow connections. You can grab a coffee or something.

Once the ISO is done and backed up, or if you've done some tweaks, you might want to reset the repository, you can go ahead and delete the `work` and `out` directories, which **requires** root privileges, which is why using the Git facilities might not work.

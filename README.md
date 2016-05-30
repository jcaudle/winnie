# winnie

A kernel built on OS X to learn Operating System concepts and Rust inspired by Steve Klabnik's _IntermezzOS_ and Phill Opperman's _Writing an OS in Rust_.

## Development Requirements

The GRUB is needed to build parts of the system (specifically the ISO on which the OS is packaged. The proper version (and necessary cross-compiling tools) can be installed by running `setup/build-grub-osx.sh`. To use the cross-compiler and the GRUB, you must add `~/opt` to your PATH.

In addition to setting up the GRUB, `xorisso`, `qemu`, and `nasm` are also required. These can be installed directly byt Homebrew.

# Introduction

The oTOSis emulator provides an Atari ST compatible environment for modern 
Linux machines.

oTOSis is not a simulation of the old hardware. Instead it consists of a m68k 
emulator, emulating the CPU of the old hardware, and then a native 
re-implementation of the operating system.

# Building

## Dependencies

oTOSis depends on the following projects:

- liboTOSis, TOS syb-system.
- oAESis, AES sub-system.
- oVDIsis, VDI sub-system.
- oCPUis, CPU emulator.

The oTOSis project brings these components together to provide an environment 
for executing m68k binaries written for TOS systems.

In addition to the projects mentioned above, the following dependencies are 
needed (on a Debian Jessie system).

- TODO

## Building

The o*is components are built using automake/autoconf and friends.

The build order that I've used with success is:

1. oCPUis
2. oVDIsis
3. liboTOSis
4. oTOSis
5. oAESis

The packages are configured using the following line:

```
CFLAGS="-I /home/e8johan/osis/inst/include" \
PATH="$PATH:/home/e8johan/osis/inst/bin" \
ACLOCAL_FLAGS="-I /home/e8johan/osis/inst/share/aclocal/" \
./autogen.sh --prefix=/home/e8johan/osis/inst/
```

They are then built using `make && make install`. This will install the 
components in `/home/e8johan/osis/inst`. Feel free to experiment to move 
things to a suitable location.

# Running

The resulting binaries will end up in the `bin` directory inside your prefix.

You can start the system using the `oaesis` binary. This provides a shell from 
which you can launch applications.

When `oaesis` is running, you can start applications from the Linux command 
line using the `tos` command.

## Troubleshooting

oAESis depends on oVDIsis for painting on the screen. oVDIsis uses something 
called _visuals_ to actually draw onto the screen. Multiple implementations of 
visuals are provided by oVDIsis. The most likely to be used on a current 
system is the SDL version. To use this, you must set the environment variable 
`OVDISIS_VISUAL` to `sdl`, e.g. start `oaesis` as `OVDISIS_VISUAL=sdl oaesis`.

# Understanding

- This will not work on a 64 bit machine without considerable effort as the 
TOS/AES/VDI APIs are designed for 32 bit pointers.

More notes will go here...
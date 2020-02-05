Portable-VirtualBox
===================

Portable-VirtualBox is a free and open source software tool that lets you run any operating system from a USB stick without separate installation.

More info is available at http://www.vbox.me/ - *the site is not updated for a long time, the information on it can be outdated.*

### Changes in this fork ###

- Updated kernel to the **latest** 5.2 version of VirtualBox.
- Old versions of the included applications are replaced with new ones.
- Fixed the English and Russian languages, the others are removed.
- Updated license to CC BY-NC-SA 4.0

### Building ###

Please see here for information on how to build from source: [BUILDING](BUILDING.md).

### Updates: Beware! ###

You probably should not use this... yet.

My updates, so far, are mostly refactoring.

Added a log for debugging, and slowly working in the old hybridmode(). 

My goal is to have the average user run portable virtual box without requiring admin. This requires drivers are already installed and I'll need to check/hash them to determine compatibility. Or if virtualbox is installed, use that instead, ie hybridmode().

Fixed a bug when running for the first time on 6.0.4+. COM error was due to user home directory not existing.

Extensions are still not handled/included yet (ever?).
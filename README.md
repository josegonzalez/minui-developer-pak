# minui-developer.pak

A MinUI app that keeps the screen awake for development purposes.

## Requirements

This pak is designed and tested on the following MinUI Platforms and devices:

- `my355`: Miyoo Flip
- `tg5040`: Trimui Brick (formerly `tg3040`), Trimui Smart Pro
- `rg35xxplus`: RG-35XX Plus, RG-34XX, RG-35XX H, RG-35XX SP

Use the correct platform for your device.

## Installation and Upgrading

1. Mount your MinUI SD card.
2. Download the [latest release](https://github.com/josegonzalez/minui-developer-pak/releases) from Github. It will be named `Developer.pak.zip`.
3. Copy the zip file to `/Tools/$PLATFORM/Developer.pak.zip`.
    1. If upgrading, delete the folder `/Tools/$PLATFORM/Developer.pak`.
4. Extract the zip in place, then delete the zip file.
5. Confirm that there is a `/Tools/$PLATFORM/Developer.pak/launch.sh` file on your SD card.
6. Unmount your SD Card and insert it into your MinUI device.

## Usage

Just start it

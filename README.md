# trimui-brick-developer.pak

A TrimUI Brick app that keeps the screen awake for development purposes.

## Requirements

- Docker (for building)

## Building

```shell
make release
```

## Installation

1. Mount your TrimUI Brick SD card.
2. Download the latest release from Github. It will be named `Developer.pak.zip`.
3. Copy the zip file to `/Tools/tg3040/Developer.pak.zip`.
4. Extract the zip in place, then delete the zip file.
5. Confirm that there is a `/Tools/tg3040/Developer.pak/launch.sh` file on your SD card.
6. Unmount your SD Card and insert it into your TrimUI Brick.

## Usage

Just start it

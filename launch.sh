#!/bin/sh
PAK_DIR="$(dirname "$0")"
PAK_NAME="$(basename "$PAK_DIR")"
PAK_NAME="${PAK_NAME%.*}"
[ -f "$USERDATA_PATH/$PAK_NAME/debug" ] && set -x

rm -f "$LOGS_PATH/$PAK_NAME.txt"
exec >>"$LOGS_PATH/$PAK_NAME.txt"
exec 2>&1

echo "$0" "$@"
cd "$PAK_DIR" || exit 1
mkdir -p "$USERDATA_PATH/$PAK_NAME"

export PATH="$PAK_DIR/bin/$PLATFORM:$PATH"

cleanup() {
    rm -f /tmp/stay_awake
    killall minui-presenter >/dev/null 2>&1 || true
}

main() {
    echo "1" >/tmp/stay_awake
    trap "cleanup" EXIT INT TERM HUP QUIT

    if [ "$PLATFORM" = "tg3040" ] && [ -z "$DEVICE" ]; then
        export DEVICE="brick"
        export PLATFORM="tg5040"
    fi

    if ! command -v minui-presenter >/dev/null 2>&1; then
        echo "minui-presenter not found" >&2
        return 1
    fi

    chmod +x "$PAK_DIR/bin/$PLATFORM/minui-presenter"

    killall minui-presenter >/dev/null 2>&1 || true
    minui-presenter --message "Press B to exit" --timeout 0
}

main "$@"

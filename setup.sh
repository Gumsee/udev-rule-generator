#!/bin/sh

error_and_exit() {
    echo "$@" >&2
    exit 1
}

UDEV_LIB_DIR="/lib/udev/"
ROOTDIR="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P)"

while true ; do
    case "$1" in
      --udev-dir)
        UDEV_LIB_DIR="$2"
        shift
        shift
        ;;
      *)
        break
        ;;
    esac
done

mkdir -p "$UDEV_LIB_DIR" || error_and_exit "Failed to create directory $UDEV_LIB_DIR"
mkdir -p "$UDEV_LIB_DIR/rules.d" || error_and_exit "Failed to create directory $UDEV_LIB_DIR/rules.d"

cp "$ROOTDIR/write_net_rules" "$UDEV_LIB_DIR/write_net_rules"
cp "$ROOTDIR/rules/75-persistent-net-generator.rules" "$UDEV_LIB_DIR/rules.d/75-persistent-net-generator.rules"

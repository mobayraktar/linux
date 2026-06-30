#!/bin/bash
set -e

DEFCONFIG="${DEFCONFIG:-t3_gem_o1_defconfig}"
OUTPUT="${OUTPUT:-/output}"
JOBS="${JOBS:-$(nproc)}"

DTB_SRC="arch/arm64/boot/dts/ti"

mkdir -p "${OUTPUT}/boot/overlays"

echo "==> Configuring with ${DEFCONFIG}"
make "${DEFCONFIG}"

echo "==> Building kernel, modules, and dtbs (jobs: ${JOBS})"
make -j"${JOBS}" Image modules dtbs

echo "==> Installing kernel image to ${OUTPUT}/boot/Image"
cp arch/arm64/boot/Image "${OUTPUT}/boot/Image"

echo "==> Installing DTB to ${OUTPUT}/boot"
cp "${DTB_SRC}/k3-am67a-t3-gem-o1.dtb" "${OUTPUT}/boot/"

echo "==> Installing overlays to ${OUTPUT}/boot/overlays"
cp "${DTB_SRC}"/k3-am67a-t3-gem-o1*.dtbo "${OUTPUT}/boot/overlays/"

echo "==> Installing modules to ${OUTPUT}"
make INSTALL_MOD_PATH="${OUTPUT}" modules_install

echo "==> Done. Output written to ${OUTPUT}"

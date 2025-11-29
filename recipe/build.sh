set -ex

meson setup build \
    ${MESON_ARGS} \
    --prefix="${PREFIX}" \
    -Dfreetype=enabled \
    -Dexamples=disabled \
    -Dtests=disabled
meson compile -C build -j ${CPU_COUNT}
meson install -C build

# Remove the private requirements which aren't leaked
sed -i'' '/^Requires\.private/d; /^Libs\.private/d' ${PREFIX}/lib/pkgconfig/plutosvg.pc

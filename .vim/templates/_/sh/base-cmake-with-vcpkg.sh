#!/bin/bash
set -euxo pipefail

if [[ "$(pwd)" != "$(cd "$(dirname "$0")" && pwd)" ]]; then
	echo 'Please cd to project diectory beforehand.' 1>&2
	exit 1
fi

build_dir=./build
install_dir=./_install
vcpkg_toolchain=~/devel/vcpkg/scripts/buildsystems/vcpkg.cmake # FIXME

make_prog=$(which ninja); generator=Ninja
#make_prog=$(which make); generator='Unix Makefiles'

njobs=$(( $(nproc)-2 ))
#njobs=$(( $(sysctl -n hw.ncpu)-2 )) # macOS

test -d $build_dir && rm -r $build_dir || true
test -d $install_dir && rm -r $install_dir || true

export CLICOLOR_FORCE=1

cmake -B "$build_dir" \
	-DCMAKE_INSTALL_PREFIX="$install_dir" \
	-DCMAKE_MAKE_PROGRAM="$make_prog" -G "$generator" \
	-DCMAKE_TOOLCHAIN_FILE="$vcpkg_toolchain" \
	-DCMAKE_COLOR_DIAGNOSTICS=ON \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_C_COMPILER=clang-20 \
	-DCMAKE_CXX_COMPILER=clang++-20 \
	-DCMAKE_CUDA_COMPILER=/usr/local/cuda-13.1/bin/nvcc
cmake --build "$build_dir" -- -j${njobs}
cmake --install "$build_dir"

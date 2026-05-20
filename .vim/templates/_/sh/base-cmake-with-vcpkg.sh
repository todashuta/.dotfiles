#!/usr/bin/env bash
set -euxo pipefail

if [[ "$(pwd)" != "$(cd "$(dirname "$0")" && pwd)" ]]; then
	echo 'Please cd to project diectory beforehand.' 1>&2
	exit 1
fi

build_dir=./build
install_dir=./_install

njobs=$(( $(nproc)-2 ))
#njobs=$(( $(sysctl -n hw.ncpu)-2 )) # macOS

test -d $build_dir && rm -r $build_dir || true
test -d $install_dir && rm -r $install_dir || true

#export VCPKG_FORCE_SYSTEM_BINARIES=1
export CLICOLOR_FORCE=1

cmake_configure_args=(
	-B "$build_dir"
	-DCMAKE_INSTALL_PREFIX="$install_dir"

	-DCMAKE_MAKE_PROGRAM="$(which ninja)" -G Ninja
	#-DCMAKE_MAKE_PROGRAM="$(which make)" -G 'Unix Makefiles'

	#-DPKG_CONFIG_EXECUTABLE=$(which pkg-config)

	-DCMAKE_TOOLCHAIN_FILE="$HOME/devel/vcpkg/scripts/buildsystems/vcpkg.cmake" # must after -DCMAKE_MAKE_PROGRAM
	-DCMAKE_COLOR_DIAGNOSTICS=ON

	#-DCMAKE_BUILD_TYPE=Debug
	-DCMAKE_BUILD_TYPE=Release

	#-DCMAKE_C_COMPILER=clang-20 -DCMAKE_CXX_COMPILER=clang++-20
	-DCMAKE_C_COMPILER=gcc-14 -DCMAKE_CXX_COMPILER=g++-14

	#-DCMAKE_CUDA_COMPILER=/usr/local/cuda-13.1/bin/nvcc

	#-DCMAKE_LINKER_TYPE=GOLD
	-DCMAKE_LINKER_TYPE=LLD

	-DCMAKE_EXPORT_COMPILE_COMMANDS=ON
)
cmake "${cmake_configure_args[@]}"
cmake --build "$build_dir" -- -j${njobs}
cmake --install "$build_dir"

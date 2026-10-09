cmake_minimum_required(VERSION 3.20)

project(ExamplePlugin VERSION 0.1.0 LANGUAGES C CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_COLOR_DIAGNOSTICS ON)

#set(CMAKE_CXX_STANDARD 23)
#set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(EXAMPLE_SDK_DIR "C:/path/to/sdk" CACHE PATH "exmaple sdk root directory")
set(EXAMPLE_SDK_INCLUDE_DIR "${EXAMPLE_SDK_DIR}/include")

add_library(${CMAKE_PROJECT_NAME} SHARED)
target_sources(${CMAKE_PROJECT_NAME}
	PRIVATE
		#"${EXAMPLE_SDK_INCLUDE_DIR}/AWESOMEAPI.cpp"
)
target_compile_definitions(${CMAKE_PROJECT_NAME}
	PRIVATE
		#EXAMPLE_FOO
		#EXAMPLE_BAR=
		#EXAMPLE_PLUGIN=1

		# project(...) の VERSION から設定される
		#EXAMPLE_VERSION_MAJOR=${PROJECT_VERSION_MAJOR}
		#EXAMPLE_VERSION_MINOR=${PROJECT_VERSION_MINOR}
		#EXAMPLE_VERSION_PATCH=${PROJECT_VERSION_PATCH}
)

target_sources(${CMAKE_PROJECT_NAME}
	PRIVATE
		src/plugin.cpp
)

#target_compile_features(${CMAKE_PROJECT_NAME} PRIVATE cxx_std_11)

target_compile_options(${CMAKE_PROJECT_NAME}
	PRIVATE
		"$<$<C_COMPILER_ID:MSVC>:/utf-8>"
		"$<$<CXX_COMPILER_ID:MSVC>:/utf-8>"
)

target_link_libraries(${CMAKE_PROJECT_NAME}
	PRIVATE
		dbghelp # SymInitialize() とか SymFromAddr() 使うときに要るやつ
)

set_target_properties(${CMAKE_PROJECT_NAME}
	PROPERTIES
		PREFIX "" # 出力されるdllのファイル名先頭に付くlibを消す
)

target_include_directories(${CMAKE_PROJECT_NAME}
	PRIVATE
		"${EXAMPLE_SDK_INCLUDE_DIR}"
)

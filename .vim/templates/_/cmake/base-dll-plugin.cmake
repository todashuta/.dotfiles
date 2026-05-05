cmake_minimum_required(VERSION 3.20)

project(ExamplePlugin LANGUAGES C CXX)

set(EXAMPLE_SDK_INCLUDE_DIR "C:/path/to/sdk/include")

target_compile_definitions(${CMAKE_PROJECT_NAME}
	PRIVATE
		#EXAMPLE_FOO
		#EXAMPLE_PLUGIN=1
)

add_library(${CMAKE_PROJECT_NAME} SHARED)
target_sources(${CMAKE_PROJECT_NAME}
	PRIVATE
		#"${EXAMPLE_SDK_INCLUDE_DIR}/AWESOMEAPI.cpp"
)

target_sources(${CMAKE_PROJECT_NAME}
	PRIVATE
		src/plugin.cpp
)

#target_compile_features(${CMAKE_PROJECT_NAME} PRIVATE cxx_std_11)

target_compile_options(${CMAKE_PROJECT_NAME}
	PUBLIC
		"$<$<C_COMPILER_ID:MSVC>:/utf-8>"
		"$<$<CXX_COMPILER_ID:MSVC>:/utf-8>"
)

set_target_properties(${CMAKE_PROJECT_NAME}
	PROPERTIES
		PREFIX "" # 出力されるdllのファイル名先頭に付くlibを消す
)

target_include_directories(${CMAKE_PROJECT_NAME}
	PUBLIC
		"${EXAMPLE_SDK_INCLUDE_DIR}"
)

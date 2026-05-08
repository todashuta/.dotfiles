cmake_minimum_required(VERSION 3.3)

project(HelloWxWidgets LANGUAGES CXX C)

#set(wxWidgets_CONFIG_EXECUTABLE /opt/local/Library/Frameworks/wxWidgets.framework/Versions/wxWidgets/3.1/bin/wx-config)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_COLOR_DIAGNOSTICS ON)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(wxWidgets COMPONENTS core base)
include(${wxWidgets_USE_FILE})

add_executable(${CMAKE_PROJECT_NAME}
	WIN32
	MACOSX_BUNDLE
)

target_sources(${CMAKE_PROJECT_NAME}
	PRIVATE
		main.cpp
)

target_compile_options(${CMAKE_PROJECT_NAME}
	PUBLIC
		"$<$<C_COMPILER_ID:MSVC>:/utf-8>"
		"$<$<CXX_COMPILER_ID:MSVC>:/utf-8>"
)

target_link_libraries(${CMAKE_PROJECT_NAME}
	PRIVATE
		${wxWidgets_LIBRARIES}
)

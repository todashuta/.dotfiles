target_compile_options(${CMAKE_PROJECT_NAME}{{_cursor_}}
	PUBLIC
		"$<$<C_COMPILER_ID:MSVC>:/utf-8>"
		"$<$<CXX_COMPILER_ID:MSVC>:/utf-8>"
)

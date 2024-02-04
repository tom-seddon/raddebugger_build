cmake_minimum_required(VERSION 3.20)
set(CMAKE_CONFIGURATION_TYPES debug release)
project(raddebugger)
set(CMAKE_SKIP_INSTALL_RULES YES)

set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT raddebugger_build)

cmake_path(SET raddebugger_path submodules/raddebugger)
cmake_path(ABSOLUTE_PATH raddebugger_path
  NORMALIZE
  BASE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  OUTPUT_VARIABLE raddebugger_path)
message(STATUS "raddebugger_path: ${raddebugger_path}")

cmake_path(NATIVE_PATH raddebugger_path raddebugger_path_native)
message(STATUS "raddebugger_path_native: ${raddebugger_path_native}")

file(GLOB_RECURSE files
  ${raddebugger_path}/src/*.c
  ${raddebugger_path}/src/*.cpp
  ${raddebugger_path}/src/*.h
  ${raddebugger_path}/src/*.mdesk
  ${raddebugger_path}/src/*.rc)

source_group(TREE ${raddebugger_path} FILES ${files})

add_executable(raddebugger)
target_sources(raddebugger PRIVATE
  ${files})
set_source_files_properties(${files} PROPERTIES HEADER_FILE_ONLY TRUE)

target_sources(raddebugger PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}/.editorconfig)

# Just some stuff to make it all kind of hang together in the IDE
# without too many squiggly lines or greyed out bits.
target_compile_definitions(raddebugger PRIVATE
  OS_WINDOWS=1)
target_include_directories(raddebugger PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}/submodules/raddebugger/src)


add_custom_target(raddebugger_build
  ALL
  COMMAND ${CMAKE_COMMAND} -E time bin/gmake.exe -r -f Makefile.build.mak CONFIG=$<CONFIG>
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})


set_target_properties(raddebugger_build PROPERTIES
  VS_DEBUGGER_COMMAND "${raddebugger_path_native}\\build\\raddbg.exe")

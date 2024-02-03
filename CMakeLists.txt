cmake_minimum_required(VERSION 3.20)
set(CMAKE_CONFIGURATION_TYPES debug)
project(raddebugger)
set(CMAKE_SKIP_INSTALL_RULES YES)

set(RADDEBUGGER_PATH submodules/raddebugger/src)

# https://cmake.org/cmake/help/latest/command/source_group.html
#
# Couldn't get this to do anything obviously useful.

# source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR}/)

file(GLOB_RECURSE files
  ${RADDEBUGGER_PATH}/*.c
  ${RADDEBUGGER_PATH}/*.cpp
  ${RADDEBUGGER_PATH}/*.h
  ${RADDEBUGGER_PATH}/*.mdesk
  ${RADDEBUGGER_PATH}/*.rc)

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
  COMMAND ${CMAKE_COMMAND} -E time bin/gmake.exe -r -f Makefile.build.mak
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

PYTHON:=py -3

SHELLCMD:=$(PYTHON) "$(realpath submodules/shellcmd.py/shellcmd.py)"

##########################################################################
##########################################################################

.PHONY:all
all:
	$(error Specify target)

##########################################################################
##########################################################################

.PHONY:init
init: _VS_PATH:=$(shell "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe" -version 16 -property installationPath) # 16 = VS2019
init: _CMAKE:=$(VS_PATH)\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe
init: _FOLDER:=build/vs2019
init:
	$(SHELLCMD) rm-tree "$(_FOLDER)"
	$(SHELLCMD) mkdir "$(_FOLDER)"
	cd "$(_FOLDER)" && cmake -G "Visual Studio 16 2019" ../../

##########################################################################
##########################################################################

# You can do make build from this Makefile, and it works, but using
# Makefile.build.mak directly is preferable as there are no $(shell)
# evaluations to add to the the starup time.
include Makefile.build.mak

.PHONY:build
build: CONFIG?=debug
build:
	submodules\raddebugger\build.bat raddbg $(CONFIG)


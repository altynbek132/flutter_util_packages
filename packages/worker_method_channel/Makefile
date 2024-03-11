DIR := web

all: compile

compile:
ifeq ($(OS),Windows_NT)
	.\compile_web_dart_js.bat
else
	./compile_web_dart_js.sh
endif

.PHONY: compile

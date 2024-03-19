DIR := web

all: compile

compile:
ifeq ($(OS),Windows_NT)
	.\compile_dart_js.bat
else
	./compile_dart_js.sh
endif

test:
	make compile
	flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart -d chrome

.PHONY: compile test

DIR := web

all: compile

compile:
ifeq ($(OS),Windows_NT)
	.\compile_dart_js.bat
else
	./compile_dart_js.sh
endif

test:
#  chromedriver --port=4444
	make compile
	flutter drive --driver=test_driver/integration_test.dart --target=integration_test/web_worker_method_channel_test.dart -d chrome

.PHONY: compile test

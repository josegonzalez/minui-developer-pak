TAG ?= latest
BUILD_DATE := "$(shell date -u +%FT%TZ)"
PAK_NAME := $(shell jq -r .label config.json)

PLATFORMS := tg5040 rg35xxplus
MINUI_BTNTEST_VERSION := 0.2.0

clean:
	rm -f bin/minui-btntest-* || true
	rm -f bin/sdl2imgshow || true
	rm -f res/fonts/BPreplayBold.otf || true

build: $(foreach platform,$(PLATFORMS),bin/minui-btntest-$(platform)) bin/sdl2imgshow bin/sleep-daemon res/fonts/BPreplayBold.otf

bin/minui-btntest-%:
	curl -f -o bin/minui-btntest-$* -sSL https://github.com/josegonzalez/minui-btntest/releases/download/$(MINUI_BTNTEST_VERSION)/minui-btntest-$*
	chmod +x bin/minui-btntest-$*

bin/sdl2imgshow:
	docker buildx build --platform linux/arm64 --load -f Dockerfile.sdl2imgshow --progress plain -t app/sdl2imgshow:$(TAG) .
	docker container create --name extract app/sdl2imgshow:$(TAG)
	docker container cp extract:/go/src/github.com/kloptops/sdl2imgshow/build/sdl2imgshow bin/sdl2imgshow
	docker container rm extract
	chmod +x bin/sdl2imgshow

bin/sleep-daemon:
	docker buildx build --platform linux/arm64 --load -f Dockerfile.sleep-daemon --progress plain -t app/sleep-daemon:$(TAG) .
	docker container create --name extract app/sleep-daemon:$(TAG)
	docker container cp extract:/go/src/github.com/josegonzalez/sleep-daemon/sleep-daemon bin/sleep-daemon
	docker container rm extract
	chmod +x bin/sleep-daemon

res/fonts/BPreplayBold.otf:
	mkdir -p res/fonts
	curl -sSL -o res/fonts/BPreplayBold.otf "https://raw.githubusercontent.com/shauninman/MinUI/refs/heads/main/skeleton/SYSTEM/res/BPreplayBold-unhinted.otf"

release: build
	mkdir -p dist
	git archive --format=zip --output "dist/$(PAK_NAME).pak.zip" HEAD
	while IFS= read -r file; do zip -r "dist/$(PAK_NAME).pak.zip" "$$file"; done < .gitarchiveinclude
	ls -lah dist

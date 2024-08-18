prefix ?= /usr/local
bindir = $(prefix)/bin
libdir = /opt/homebrew/Cellar/etc

build:
	swift build -c release
install: build
	install -d "$(bindir)" "$(libdir)"
	install ".build/release/mmaf" "$(bindir)"
	install "./Sources/mmaf/mirrors_list.plist" "$(libdir)"
	sudo chmod 777 "$(libdir)/mirrors_list.plist"

uninstall:
	rm -rf "$(bindir)/mmaf"
	rm -rf "$(libdir)/mirrors_list.plist"

clean:
	rm -rf .build

.PHONY: build install uninstall clean

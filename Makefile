prefix ?= /usr/local
bindir = $(prefix)/bin
libdir = /opt/homebrew/etc/mmaf-rec

build:
	swift build -c release --disable-sandbox

install: build
	install -d "$(bindir)" "$(libdir)"
	install ".build/release/mmaf" "$(bindir)"
	install "./Sources/mmaf/mirrors_list.plist" "$(libdir)"


uninstall:
	rm -rf "$(bindir)/mmaf"
	rm -rf "$(libdir)/mirrors_list.plist"

clean:
	rm -rf .build

.PHONY: build install uninstall clean

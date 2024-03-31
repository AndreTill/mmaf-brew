prefix ?= /usr/local
bindir = $(prefix)/bin
libdir = /usr/local/lib

build:
	swift build -c release
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

APP := window-border
SRC := Sources/main.m
BUNDLE := WindowBorder.app

.PHONY: all app clean run

all: $(APP)

$(APP): $(SRC)
	clang -fobjc-arc -O2 -Wall -Wextra -arch arm64 -arch x86_64 \
		-framework Cocoa \
		-framework CoreGraphics \
		-framework ServiceManagement \
		-o $@ $<

app: $(APP)
	rm -rf $(BUNDLE)
	mkdir -p $(BUNDLE)/Contents/MacOS $(BUNDLE)/Contents/Resources
	cp $(APP) $(BUNDLE)/Contents/MacOS/WindowBorder
	cp Info.plist $(BUNDLE)/Contents/Info.plist
	cp AppIcon.icns $(BUNDLE)/Contents/Resources/AppIcon.icns
	printf 'APPL????' > $(BUNDLE)/Contents/PkgInfo

# Build and copy into /Applications for everyday use.
install: app
	rm -rf /Applications/$(BUNDLE)
	cp -R $(BUNDLE) /Applications/
	@echo "Installed to /Applications/$(BUNDLE). Open it, then use the menu-bar icon → Open at Login."

run: $(APP)
	./$(APP)

clean:
	rm -rf $(APP) $(BUNDLE)

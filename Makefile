APP := window-border
SRC := Sources/main.m
BUNDLE := WindowBorder.app

.PHONY: all app clean run

all: $(APP)

$(APP): $(SRC)
	clang -fobjc-arc -O2 -Wall -Wextra -arch arm64 -arch x86_64 \
		-framework Cocoa \
		-framework CoreGraphics \
		-o $@ $<

app: $(APP)
	rm -rf $(BUNDLE)
	mkdir -p $(BUNDLE)/Contents/MacOS
	cp $(APP) $(BUNDLE)/Contents/MacOS/WindowBorder
	cp Info.plist $(BUNDLE)/Contents/Info.plist
	printf 'APPL????' > $(BUNDLE)/Contents/PkgInfo

run: $(APP)
	./$(APP)

clean:
	rm -rf $(APP) $(BUNDLE)

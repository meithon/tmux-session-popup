PREFIX ?= $(HOME)/.local
BINDIR := $(DESTDIR)$(PREFIX)/bin
SHAREDIR := $(DESTDIR)$(PREFIX)/share/tmux-session-popup

SCRIPTS := tmux-session-switcher tmux-session-widget tmux-zoxide-session
TMUX_FILES := tmux-session-switcher.tmux tmux-session-switcher.plugin tmux-session-popup.tmux

.PHONY: install uninstall

install:
	@mkdir -p "$(BINDIR)"
	@for f in $(SCRIPTS); do \
		install -m 755 "bin/$$f" "$(BINDIR)/$$f"; \
	done
	@mkdir -p "$(SHAREDIR)"
	@for f in $(TMUX_FILES); do \
		install -m 644 "$$f" "$(SHAREDIR)/$$f"; \
	done
	@printf 'Installed scripts to %s\n' "$(BINDIR)"
	@printf 'Installed tmux plugin files to %s\n' "$(SHAREDIR)"

uninstall:
	@for f in $(SCRIPTS); do \
		rm -f "$(BINDIR)/$$f"; \
	done
	@for f in $(TMUX_FILES); do \
		rm -f "$(SHAREDIR)/$$f"; \
	done
	@printf 'Removed scripts from %s\n' "$(BINDIR)"
	@printf 'Removed tmux plugin files from %s\n' "$(SHAREDIR)"

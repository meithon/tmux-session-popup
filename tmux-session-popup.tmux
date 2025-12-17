#!/usr/bin/env bash

# Defaults (can be overridden by tmux options)
DEFAULT_NEXT_KEY="C-Tab"
DEFAULT_PREV_KEY="C-S-Tab"

# Resolve plugin dir (where this file lives)
PLUGIN_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Read tmux options (fall back to defaults)
SESSION_SWITCHER_NEXT_KEY="$(tmux show-option -gqv @session_switcher_next_key)"
SESSION_SWITCHER_PREV_KEY="$(tmux show-option -gqv @session_switcher_prev_key)"
WIDGET_MODE_OPT="$(tmux show-option -gqv @session_switcher_widget_mode)"

# Always set widget path to the bundled widget (prefer stable default)
WIDGET_PATH="$PLUGIN_DIR/bin/tmux-session-widget"
tmux set-option -gq @session_widget_path "$WIDGET_PATH"

if [[ -z "$SESSION_SWITCHER_NEXT_KEY" ]]; then
  SESSION_SWITCHER_NEXT_KEY="$DEFAULT_NEXT_KEY"
fi
if [[ -z "$SESSION_SWITCHER_PREV_KEY" ]]; then
  SESSION_SWITCHER_PREV_KEY="$DEFAULT_PREV_KEY"
fi
if [[ -z "$WIDGET_MODE_OPT" ]]; then
  WIDGET_MODE_OPT="list"
fi

# Bind keys
tmux bind-key -n "$SESSION_SWITCHER_NEXT_KEY" run-shell "TMUX_SESSION_WIDGET_PATH=$WIDGET_PATH WIDGET_MODE=$WIDGET_MODE_OPT $PLUGIN_DIR/bin/tmux-session-switcher next"
tmux bind-key -n "$SESSION_SWITCHER_PREV_KEY" run-shell "TMUX_SESSION_WIDGET_PATH=$WIDGET_PATH WIDGET_MODE=$WIDGET_MODE_OPT $PLUGIN_DIR/bin/tmux-session-switcher prev"

# Provide status-line format variable (does not overwrite status-right)
if [[ -z "$(tmux show-option -gqv @session_status_format)" ]]; then
  tmux set-option -gq @session_status_format "#($PLUGIN_DIR/bin/tmux-session-status)"
fi

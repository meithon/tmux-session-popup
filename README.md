# tmux-panehop

![panehop](https://img.shields.io/badge/tmux-panehop-blue.svg)

## Overview

`panehop` is a lightweight tmux plugin that lists all panes across sessions and windows in an interactive [fzf](https://github.com/junegunn/fzf) interface. Quickly switch to a pane with Enter or kill a pane with Ctrl-X, all while previewing pane contents in real-time.

## Features

- List panes from all tmux sessions and windows
- Live pane content preview
- Switch to a pane with Enter
- Kill a pane with Ctrl-X (and reload the list)
- Minimal dependencies: tmux, fzf, TPM (Tmux Plugin Manager) or manual setup

## Demo

![Demo GIF](https://user-images.githubusercontent.com/…/demo.gif)

> *Demo GIF is illustrative; actual appearance may vary.*

## Requirements

- tmux v2.6+
- [fzf](https://github.com/junegunn/fzf)
- [Tmux Plugin Manager (TPM)](https://github.com/tmux-plugins/tpm) (optional)

## Installation

### TPM (Recommended)

1. Add to your `~/.tmux.conf`:
   ```tmux
set -g @plugin 'yourname/tmux-panehop'
run '~/.tmux/plugins/tpm/tpm'
   ```
2. Reload tmux configuration:
   ```
   prefix + : source-file ~/.tmux.conf
   ```
3. Install plugins:
   ```
   prefix + I
   ```

### Manual

```bash
git clone https://github.com/yourname/tmux-panehop.git ~/.tmux/plugins/panehop
```

Add to your `~/.tmux.conf`:
```tmux
run-shell "~/.tmux/plugins/tmux-panehop/tmux-panehop.tmux"
```

Reload tmux or restart your session.

## tmux-session-switcher（このリポの別ツール）

### インストール（ローカル配置）

```bash
make install            # デフォルト: ~/.local/bin へインストール
# PREFIX を変えたい場合
make install PREFIX=/usr/local
```

アンインストール:

```bash
make uninstall          # 同じ PREFIX を指定すると確実です
```

### tmux への組み込み（TPM/plugin）

`~/.tmux.conf` に追記:

```tmux
set -g @plugin 'yourname/tmux-session-popup'
run '~/.tmux/plugins/tpm/tpm'

# オプション（必要に応じて）
set -g @session_widget_path ~/.tmux/plugins/tmux-session-popup/bin/tmux-session-widget
set -g @session_switcher_widget_mode list  # または dots
set -g @session_switcher_next_key C-Tab    # 好きなキーに変更可（例: F）
set -g @session_switcher_prev_key C-S-Tab
```

TPM 以外で手動ロードする場合:

```tmux
run-shell "~/.tmux/plugins/tmux-session-popup/tmux-session-switcher.tmux"
```

TPM で自動ロードするときの挙動

`set -g @plugin 'yourname/tmux-session-popup'` を設定すると、TPM がリポ直下の
`tmux-session-popup.tmux` を自動で source します。その中から
`tmux-session-switcher.tmux` を呼ぶので、追加の run-shell は不要です。

### 直接バインドで試す（TPMなし）

```tmux
bind-key -n C-Tab    run-shell "WIDGET_MODE=dots ~/.local/bin/tmux-session-switcher next"
bind-key -n C-S-Tab  run-shell "WIDGET_MODE=dots ~/.local/bin/tmux-session-switcher prev"
```

> `WIDGET_MODE` は `list`（デフォルト）か `dots` を指定できます。`TMUX_SESSION_WIDGET_PATH` を指定すれば別ウィジェットにも差し替え可。

## Usage

- Press `prefix + s` (default) to launch the pane switcher
- Use arrow keys or type to filter panes
- Press Enter to switch to a selected pane
- Press Ctrl-X to kill a pane and refresh the list

## Configuration

- To change the key binding, add to `~/.tmux.conf`:
  ```tmux
  set -g @tmux_panehop_key 'S'  # e.g., prefix + Shift-S
  ```
- For advanced fzf options, edit `bin/panehop` directly.

## Contributing

1. Fork this repository
2. Clone locally (`git clone ...`)
3. Make changes in `bin/panehop` or `panehop.tmux`
4. Test and submit a Pull Request

## License

MIT © [Your Name]

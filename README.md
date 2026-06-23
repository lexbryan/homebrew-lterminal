# lterminal

Tile the **Terminal.app** windows visible on your current macOS Space into an
equal, near-square grid that fills the usable area of the active display.

```
lterminal snap
```

One ultrawide with six terminals open → a clean 3×2 grid, menu bar and Dock
respected, in a single command.

## How it works

Pure JXA (JavaScript for Automation) driven by a small Bash dispatcher — no
third-party dependencies, nothing to compile:

- **Terminal scripting dictionary** — reads and sets each window's `bounds`.
- **`CGWindowListCopyWindowInfo`** — restricts the set to windows on the
  *current Space* (matched to Terminal windows by id, which equals the
  CGWindowNumber).
- **`NSScreen.visibleFrame`** — the usable rectangle, with menu bar and Dock
  already subtracted, per display.

The grid is wide-biased on landscape displays and tall-biased on portrait ones.
When the window count doesn't fill the grid evenly, the leftover stretches into a
full-height **vertical column** beside the block by default — a tall terminal
next to a grid of shorter ones (e.g. 5 windows → a 2×2 block + one tall column).
Pass `--horizontal` to stretch it as a wide bottom row instead.

## Install

**Homebrew (recommended):**

```sh
brew tap lexbryan/lterminal
brew install lterminal
```

Newer Homebrew gates third-party taps behind a one-time approval — if it asks,
run `brew trust lexbryan/lterminal` and re-run the install.

**Without Homebrew:**

```sh
./install.sh                # symlinks lterminal into ~/bin
./install.sh /usr/local/bin # or a directory of your choice
```

## Commands

```sh
lterminal snap                 # tile current Space + active display (vertical-last)
lterminal snap --horizontal    # leftover stretches as a wide bottom row instead
lterminal snap cols            # full-height columns, side by side
lterminal snap rows            # full-width rows, stacked
lterminal snap 2x2             # force a grid (auto-expands if too small)
lterminal max                  # maximize the focused window to its display
lterminal cycle                # rotate windows through their slots (--reverse to flip)
lterminal list                 # list the current-Space Terminal windows
lterminal save work            # snapshot the current arrangement as "work"
lterminal restore work         # put the windows back
lterminal layouts              # list saved arrangements
```

Common options: `--dry-run` (plan only), `--gap <px>`, `--margin <px>`,
`--all-displays`, `--json`. Run `lterminal help` for the full list.

> `save`/`restore` match windows by their Terminal window id, so a saved layout
> restores within the same session; ids reset when Terminal restarts.

## Permissions

The first run prompts **"Terminal wants to control Terminal"** — approve it
(System Settings → Privacy & Security → Automation). That's the only grant
needed; no Accessibility or Screen Recording permission is required.

## Distribution (single Homebrew tap repo)

`lterminal` ships as **its own Homebrew tap** — one repo, named
`homebrew-lterminal`, holding both the code and `Formula/lterminal.rb`. The
`homebrew-` prefix is what lets `brew` recognize it as a tap; the tool is still
`lterminal` everywhere a user looks.

1. Create the GitHub repo **`homebrew-lterminal`** and push this folder to it
   (the local folder name doesn't matter — only the GitHub repo name does).
2. Tag a release so the formula has something to download:
   ```sh
   git tag v0.1.0 && git push --tags
   ```
3. Fill the formula's `url`/`sha256` (skip if you only ship `--HEAD`):
   ```sh
   curl -L https://github.com/lexbryan/homebrew-lterminal/archive/refs/tags/v0.1.0.tar.gz | shasum -a 256
   ```
4. Anyone installs — and `brew upgrade` keeps it current — with:
   ```sh
   brew install lexbryan/lterminal/lterminal
   # or straight from main, no release needed:
   brew install --HEAD lexbryan/lterminal/lterminal
   ```

Replace `lexbryan` with your GitHub username if different.

> **Want the repo named just `lterminal`?** You can, but you lose the clean
> shorthand above: brew's tap shorthand requires the `homebrew-` prefix, so
> users would need `brew tap lexbryan/lterminal <git-url>` (explicit URL) before
> installing, or `brew install <raw-formula-URL>` (which can't `brew upgrade`).

## Roadmap

Ideas not yet built: per-window pinning, gaps/margins persisted in a config
file, and matching saved layouts by title/working-dir so they survive a Terminal
restart.

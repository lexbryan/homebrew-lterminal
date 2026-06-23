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

Windows are sorted row-major before placement, the grid is wide-biased on
landscape displays and tall-biased on portrait ones, and a partial final row
stretches to fill the width.

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

## Usage

```sh
lterminal snap                 # tile the current Space + active display
lterminal snap --dry-run       # show the plan, move nothing
lterminal snap --gap 8         # 8px gutters between windows
lterminal snap --margin 12     # 12px outer margin
lterminal snap --grid 2x2      # force a specific grid
lterminal snap --all-displays  # tile each display independently
lterminal snap --json          # machine-readable output
```

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

`snap cols` / `snap rows` · `max` (focused window only) · `save`/`restore`
named layouts · `cycle` (rotate windows through slots).

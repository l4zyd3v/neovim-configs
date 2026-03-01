# AGENTS.md
Guidance for agentic coding tools working in this repository.

## 1) Repository Snapshot
- Root: `~/.config/nvim`
- Primary language: Lua
- Runtime: Neovim (`nvim`)
- Plugin manager: `lazy.nvim`
- Lockfile: `lazy-lock.json`
- Main entry: `init.lua`
- Main code tree: `lua/lazyd3v/`
- Key directories:
  - `lua/lazyd3v/core/`: options, keymaps, user commands, helpers
  - `lua/lazyd3v/plugins/`: plugin specs and plugin config
  - `lua/lazyd3v/plugins/lsp/`: Mason and LSP setup
  - `.stylua.toml`: formatting policy

## 2) Instruction Precedence
If instructions conflict, follow this order:
1. Direct user request
2. This file (`AGENTS.md`)
3. Existing local patterns in nearby files
4. Upstream plugin defaults

## 3) Build / Lint / Test Commands
This repository has no traditional app build step.
Validation is done via formatting and headless Neovim startup checks.

### Core validation
- Format all Lua files: `stylua .`
- Check formatting only: `stylua --check .`
- Minimal runtime smoke test: `nvim --headless "+qa"`
- Health diagnostics: `nvim --headless "+checkhealth" "+qa"`

### Plugin restore/sync
- Restore lockfile versions: `nvim --headless "+Lazy! restore" "+qa"`
- Sync plugin specs: `nvim --headless "+Lazy! sync" "+qa"`
- Notes:
  - `telescope-fzf-native.nvim` uses `build = "make"`; ensure `make` is installed.
  - Prefer `Lazy! restore` for deterministic plugin state.

### Linting
- No standalone repo-wide lint command is configured for this Lua config.
- In-editor linting is configured via `nvim-lint` in `lua/lazyd3v/plugins/linting.lua`.
- Current configured linters:
  - JavaScript / TypeScript: `eslint_d`
  - Python: `pylint`
- For agent workflows, baseline gate is:
  - `stylua --check .`
  - `nvim --headless "+qa"`

### Tests
- Current state:
  - No dedicated automated test suite is present.
  - No `tests/` or `spec/` tree exists right now.
  - No canonical `test` or `test:single` command exists yet.

### Running a single test (when tests are introduced)
If this repository adopts Plenary/Busted tests, use:
- Single test file:
  - `nvim --headless -c "PlenaryBustedFile tests/path/to/file_spec.lua" -c "qa"`
- Single test directory:
  - `nvim --headless -c "PlenaryBustedDirectory tests/path/to/dir { minimal_init = './tests/minimal_init.lua' }" -c "qa"`
- If a different framework is added, update this section immediately.

## 4) Code Style Guidelines

### Imports and module loading
- Use `local x = require("module.path")` for dependencies.
- Place `require` calls near top-level unless lazy-loading is intentional.
- Use `pcall(require, "...")` only for optional modules and graceful fallback behavior.
- Alias frequently used APIs when it improves readability (for example `local keymap = vim.keymap`).

### Formatting and whitespace
- Follow Stylua output; do not hand-format against it.
- Indentation is 2 spaces (`.stylua.toml`).
- Use spaces, not tabs.
- Keep multiline tables trailing-comma friendly to reduce diff noise.
- Prefer readable line breaks over dense one-liners.

### Types and annotations
- Lua is dynamic here; no strict typed Lua checker is configured.
- EmmyLua annotations are optional and should be used only when they add clarity.
- Accepted patterns include:
  - `---@type ...`
  - `---@module ...`
- Avoid annotation noise in straightforward code.

### Naming conventions
- Local variables and functions: `snake_case`.
- Module names and file paths: lowercase `snake_case` where practical.
- Prefer descriptive names (`on_attach`, `capabilities`, `opencode_cmd`) over abbreviations.
- Avoid single-letter names except in tiny loop scopes.

### Plugin spec and config conventions
- Plugin files typically return a Lazy spec table:
  - `return { "author/plugin", ... }`
- Keep plugin setup in `config = function() ... end`.
- Keep dependency declarations explicit and near the plugin spec.
- Reuse shared setup patterns where possible (for example LSP `on_attach` + `capabilities`).

### Keymaps and commands
- Prefer `vim.keymap.set` for new mappings.
- Include `desc` for discoverability.
- Use buffer-local mappings for buffer-scoped behavior.
- Keep keymaps close to the feature they configure.

### Error handling and resilience
- Check process failures (`vim.v.shell_error`) after `vim.fn.system` calls.
- Fail fast on unrecoverable bootstrap errors with actionable messages.
- Guard optional plugin usage with `pcall(require, ...)`.
- Prefer explicit user-facing feedback (`vim.notify` or clear `print`) over silent failure.

### Filesystem and shell usage
- Prefer Neovim/Lua APIs (`vim.fn`, `vim.uv`/`vim.loop`) over ad hoc shell calls.
- Ensure directories exist before writing files.
- Avoid hard-coded absolute paths when possible; isolate/document them when unavoidable.

### Comments and documentation
- Comment intent, not obvious syntax.
- Keep comments concise and accurate.
- Remove stale commented-out code when it no longer adds context.
- Preserve attribution comments when adapting external code.

## 5) Cursor and Copilot Rules
Checked locations:
- `.cursorrules`
- `.cursor/rules/`
- `.github/copilot-instructions.md`
Result:
- No Cursor rule files or Copilot instruction files were found.
- If these files are added later, treat them as mandatory supplemental instructions.

## 6) Change Checklist for Agents
Before finishing a change:
1. Run `stylua --check .`
2. Run `nvim --headless "+qa"`
3. If plugin specs changed, run `nvim --headless "+Lazy! restore" "+qa"`
4. Re-run `nvim --headless "+qa"` after restore/sync
5. Update `AGENTS.md` when commands or conventions change

## 7) Commit Hygiene (Recommended)
- Keep commits focused on one concern.
- Write commit messages that explain intent (why), not only file churn (what).
- Avoid mixing unrelated refactors with behavior changes.

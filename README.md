# Neovim IDE configuration

This configuration is straightforward, without complex directory structures or dependencies.

Although simple, it configures an **IDE** for a robust development environment.
This is not just a basic `vim` setup for editing a few lines on a remote server.

The setup is influenced by hundreds of articles, forum threads, Neovim setup videos, and my existing vim configuration.

This configuration is a continuous Work In Progress.

## Requirements

The setup depends on several CLI tools and libraries available on your system.

- [Nerd Fonts](https://www.nerdfonts.com) - for icons and symbols
- [rg](https://github.com/BurntSushi/ripgrep) - many Neovim plugins rely on this great `grep` replacement.

Additional tools may be required. Refer to [lua/plugins/conform.lua](lua/plugins/conform.lua), [lua/plugins/mason.lua](lua/plugins/mason.lua), or [lua/plugins/lint.lua](lua/plugins/lint.lua) for examples.
These plugin definitions list various external tools for linting and formatting. Neovim (via [Mason](https://github.com/williamboman/mason.nvim) plugin) can install them automatically, though many may already be available on your system.

## Installation

Clone this repository into ~/.config/

```sh
git clone https://github.com/den-is/nvim.git ~/.config/nvim

# Run Neovim
nvim
```

After the initial installation, check Neovim's health:

```sh
# In Neovim's command mode run
:checkhealth
# This will report any missing critical binaries, among other messages.

# Note: Not all warnings or errors need to be addressed.
#       Ignore warnings if the recommended actions don't align with your system setup.
```

If you want to test this configuration without affecting your existing Neovim installation.
You can have multiple Neovim's distinct configurations in parallel.

```sh
git clone https://github.com/den-is/nvim.git ~/.config/nvim-test

# Run Neovim
NVIM_APPNAME=nvim-test nvim
# Note: NVIM_APPNAME should match the Neovim directory name in `~/.config`.
```

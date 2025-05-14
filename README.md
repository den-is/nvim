# Neovim IDE configuration

<a href="https://dotfyle.com/den-is/nvim"><img src="https://dotfyle.com/den-is/nvim/badges/plugins?style=flat-square" /></a>
<a href="https://dotfyle.com/den-is/nvim"><img src="https://dotfyle.com/den-is/nvim/badges/leaderkey?style=flat-square" /></a>
<a href="https://dotfyle.com/den-is/nvim"><img src="https://dotfyle.com/den-is/nvim/badges/plugin-manager?style=flat-square" /></a>

Simple and straightforward, but still quite complex Neovim configuration.
This is not a plain `vim` setup for just editing a couple of lines, but more or less fully featured IDE.

## Requirements

- **[Neovim](https://neovim.io)** - **version 0.11.0 or higher**
- [Nerd Fonts](https://www.nerdfonts.com) - for icons and symbols
- [rg](https://github.com/BurntSushi/ripgrep) - many Neovim plugins rely on this great `grep` replacement

Additional tools may be required.  
Refer to [lua/plugins/conform.lua](lua/plugins/conform.lua), [lua/plugins/mason.lua](lua/plugins/mason.lua), or [lua/plugins/lint.lua](lua/plugins/lint.lua) for examples.  
These plugins definitions list various external tools for linting and formatting.  
Neovim (via [Mason](https://github.com/williamboman/mason.nvim) plugin) can install them automatically, though many may already be available on your system, if you installed them via your package manager or manually.

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
# Note: NVIM_APPNAME should match the Neovim directory name in the `~/.config/` directory.
```

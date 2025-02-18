<div align="center">

# Neovim configuration

</div>

This is my neovim configuration. The main goal I want to achieve is a configuration I can safely take
anywhere without much overhead while being able to control the level complexity of the editor.

## Goals

- When plugins, external applications and/or terminal capabilities are missing, neovim fallbacks to
  just setting some mappings, options, autocmds, etc.
- No automatic installation or downloads on initialization. All such routines must have been triggered
  by the use of some [`:Command`][nvim.commands.help]
- Use [`:Commands`][nvim.commands.help] to manage the editor capabilities.

## Install

Clone the repository.

```sh
git clone https://github.com/4ngelf/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
```

See also: [`:help standard-path`][nvim.standardpaths.help]

<!-- Links -->
[nvim.commands.help]: https://neovim.io/doc/user/cmdline.html#cmdline
[nvim.standardpaths.help]: https://neovim.io/doc/user/starting.html#_standard-paths

<div align="center">

# Neovim configuration

</div>

This is my neovim configuration. The main goal I want to achieve is a configuration I can safely take
anywhere without much overhead while being able to control the level complexity of the editor.

## Goals

- When plugins, external applications and/or terminal capabilities are missing, neovim tries to
  configurate the bare minimum of mappings, options, etc.
- Use [:\{Commands\}][nvim.commands.help] to manage the editor capabilities.
- No automatic installation or downloads on initialization. Every such action must be explitcly with
- the use of commands.

## Install

Clone the repository.

```sh
git clone https://github.com/4ngelf/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
```

See also: [`:help standard-path`][nvim.standardpaths.help]

<!-- Links -->
[nvim.commands.help]: https://neovim.io/doc/user/cmdline.html#cmdline
[nvim.standardpaths.help]: https://neovim.io/doc/user/starting.html#_standard-paths

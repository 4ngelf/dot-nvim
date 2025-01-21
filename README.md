<div align="center">

# Neovim configuration

</div>

This is my neovim configuration. The main goal is a configuration that just works in any environment
that neovim supports while still being easy to modify and manage.


## Goals

- When plugins, external applications and/or terminal capabilities are missing, neovim tries to
  configurate the bare minimum of mappings, options, etc.
- Everything works the same in any platform.
- Administrate configuration and dependencies with [:\{Commands\}][nvim.commands.help]
- No automatic installation of external programs on initialization.
- Neovim needs to ask the user before automatic access of resources outside the [standard
  paths][nvim.standardpaths.help]. Including network access.


## Install

Clone the repository.

```sh
git clone git@github.com:4ngelf/nvim.git "${XDG_CONFIG_HOME}/nvim"
```

See also: [`:help standard-path`][nvim.standardpaths.help]

<!-- Links -->
[nvim.commands.help]: https://neovim.io/doc/user/cmdline.html#cmdline
[nvim.standardpaths.help]: https://neovim.io/doc/user/starting.html#_standard-paths

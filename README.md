<div align="center">

# Neovim configuration

</div>

> [!WARNING]
> Right now this just a proof of concept and it's not ready as a text editor.

This is my neovim configuration based on features and modularity. The main goal
is a configuration that just works in any environment that neovim supports while
still being easy to modify and manage.

## Philosophy

- Neovim works at a minimum level with the absense of plugins, external applications and/or terminal
  capabilities.
- Any feature is available only when the necessary requirements are met.
- Everything is the same in any platform.
- The user is responsible for dependencies.
- Neovim helps manage features and dependencies with [`:Commands`][nvim.commands.help] and
  configuration files.
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

<div align="center">

# Neovim configuration

</div>

This is my neovim configuration. The main goal I want to achieve is a configuration I can safely take
anywhere without much overhead while being able to control the level complexity of the editor.

## Goals

- **Lightweight**: Just a subset of all plugins are available at first. The rest of can be installed anytime.
- **Adaptable**: Extra tweaks are made on special environments like on Windows, GUI apps, remote, etc.
- **Batteries**: Define utilities and use popular luarocks libraries to enhance the code.

## Install

Clone the repository.

```sh
git clone https://github.com/4ngelf/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
```

See also: [`:help standard-path`][nvim.standardpaths.help]

<!-- Links -->
[nvim.standardpaths.help]: https://neovim.io/doc/user/starting.html#_standard-paths

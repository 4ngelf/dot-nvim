<h1>
  <img height="100px" valign="middle" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/neovim/neovim-original.svg">
  &nbsp;configuration
</h1>

This is my neovim configuration files. Everything is geared towards modularity, portability and reconfiguration.

### Goals

- **Lightweight**: Just a subset of all plugins are available at first.
- **Batteries**: Define utilities and use popular libraries to enhance the code.
- **Management**: Define user commands to manage the editor complexity.
- **Adaptable**: Apply extra tweaks as needed on special environments like on Windows, GUI apps, remote, etc.

## Dependencies

- neovim >= `0.10` (luajit)
- git
- [lazy.nvim](https://lazy.folke.io/)
- [luarocks](https://luarocks.org/)

## Install

Clone the repository.

```sh
git clone https://github.com/4ngelf/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
```

See also: [`:help standard-path`][nvim.standardpaths.help]

<!-- Links -->
[nvim.standardpaths.help]: https://neovim.io/doc/user/starting.html#_standard-paths

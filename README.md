<h1>
  <img height="100px" valign="middle" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/neovim/neovim-original.svg">
  &nbsp;configuration
</h1>

This is my neovim configuration files. Everything is geared towards modularity, portability and reconfiguration.

### Goals

- **Lightweight**: Just a subset of all plugins are available at first.
- **Batteries**: Define utilities and use popular libraries to enhance the code.
- **Management**: Define user commands to manage the editor complexity.
- **Adaptable**: Apply extra tweaks as needed on special environments like on Windows, terminal/GUI apps, remote, etc.

## Dependencies

This is a list of dependencies which can't be automatically installed: 

- [neovim](https://neovim.io/) >= `0.10` (luajit)
- [git](https://git-scm.com/)
- [lazy.nvim](https://lazy.folke.io/)
- [luarocks](https://luarocks.org/)

### Extra dependencies for lazyvim

- C compiler <sub>_suggestions_: gnu's `gcc`, llvm's `clang`, MSVC's `cl.exe`, `zig`</sub>
- curl
- [fzf](https://github.com/junegunn/fzf), [ripgrep](https://github.com/BurntSushi/ripgrep) and [fd](https://github.com/sharkdp/fd)

## Install

Clone the repository.

```sh
git clone https://github.com/4ngelf/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
```

See also: [`:help standard-path`][nvim.standardpaths.help]

<!-- Links -->
[nvim.standardpaths.help]: https://neovim.io/doc/user/starting.html#_standard-paths

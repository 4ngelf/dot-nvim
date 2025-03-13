xdg := justfile_directory() / ".xdg"
export XDG_CONFIG_HOME := xdg / "config"
export XDG_DATA_HOME := xdg / "data"
export XDG_CACHE_HOME := xdg / "cache"
export XDG_STATE_HOME := xdg / "state"

nvim_rtp := 'lua vim.opt.rtp:remove(vim.fn.stdpath("config")); vim.opt.rtp:prepend(vim.uv.cwd())'
nvim := "nvim --cmd " + quote(nvim_rtp) + " -u ./init.lua"

# run `nvim` using this configuration
run *ARGS="./init.lua":
    {{nvim}} {{ARGS}}

# run tests with `busted`
test:
    # No tests yet

alias t := test

# format all source files
format:
    stylua .

alias fmt := format

# clean `.xdg`
clean:
    rm -vrf {{quote(xdg)}}

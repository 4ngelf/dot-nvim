nvim_rtp := 'lua vim.opt.rtp:remove(vim.fn.stdpath("config")); vim.opt.rtp:prepend(vim.uv.cwd())'
nvim := "nvim --cmd " + quote(nvim_rtp) + " -u ./init.lua"

# run `nvim` using this configuration
run *ARGS="./init.lua":
    {{nvim}} {{ARGS}}

# format all source files
format:
    stylua .

alias fmt := format

# run tests with busted
test:
    # No tests yet

alias t := test

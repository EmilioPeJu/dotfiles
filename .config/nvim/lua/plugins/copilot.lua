return {
    {
        'zbirenbaum/copilot.lua',
        config = function(_, opts)
            require('copilot').setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
                filetypes = {
                    bitbake = true,
                    c = true,
                    cpp = true,
                    nix = true,
                    python = true,
                    systemd = true,
                    vhdl = true,
                    ["*"] = false,
                },
            })
        end
    }
}

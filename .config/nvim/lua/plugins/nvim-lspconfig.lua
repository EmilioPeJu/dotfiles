return {
    {
        'neovim/nvim-lspconfig',
        config = function()
            local lspconfig = require('lspconfig')
            -- lspconfig.pyright.setup({})
            lspconfig.ruff.setup({})
            lspconfig.rust_analyzer.setup{
                settings = {
                    ['rust-analyzer'] = { }
                }
            }
        end
    },
}

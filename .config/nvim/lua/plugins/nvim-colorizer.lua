return {
    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            vim.opt.termguicolors = true
            require('colorizer').setup()
        end,
    }
}

return {
    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            -- Enable termguicolors to make this plugin work
            vim.opt.termguicolors = true
            require('colorizer').setup()
        end,
    }
}

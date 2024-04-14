-- nnoremap <leader>g :Telescope live_grep<CR>
return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        keys = {
            '<leader>f',
            '<leader>h',
            '<leader><leader>',
            '<leader>.',
            '<leader>g',
        },
        opts = {
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            }
        },
        config = function(_, opts)
            require('telescope').setup(opts)
            require('telescope').load_extension('fzf')
            local map = vim.keymap.set
            map('n', '<leader>f',
                function()
                    require('telescope.builtin').find_files()
                end)
            map('n', '<leader>h',
                function()
                    require('telescope.builtin').help_tags()
                end)
            map('n', '<leader><leader>',
                function()
                    require('telescope.builtin').buffers()
                end)
            map('n', '<leader>.',
                function()
                    require('telescope.builtin').treesitter()
                end)
            map('n', '<leader>g',
                function()
                    require('telescope.builtin').live_grep()
                end)
        end,
        dependencies = {
            {
                'nvim-lua/plenary.nvim'
            },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make'
            },
        },
    }
}
-- nnoremap <leader>g :Telescope live_grep<CR>
return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        lazy = false,
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
            map('n', '<leader>l',
                function()
                    require('telescope.builtin').live_grep({
                        prompt_title = 'Grep buffers',
                        grep_open_files = true,
                    })
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

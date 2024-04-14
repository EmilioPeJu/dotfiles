return {
    {
        'mhinz/vim-startify',
        config = function()
            -- Bindings
            local map = vim.keymap.set
            map('n', '<leader>s', ':Startify<CR>', { noremap = true })
        end
    }
}

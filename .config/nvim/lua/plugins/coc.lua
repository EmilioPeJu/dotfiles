return {
    {
        'neoclide/coc.nvim',
        branch = 'release',
        config = function()
            local g = vim.g
            g.coc_global_extensions = {
                'coc-rust-analyzer',
                'coc-pyright',
                'coc-sh'
            }
            g.coc_snippet_next = '<tab>'
            g.coc_snippet_prev = '<s-tab>'
            g.coc_snippet_confirm = '<cr>'
            g.coc_snippet_cancel = '<esc>'
            g.coc_snippet_placeholder_next = '<tab>'
            g.coc_snippet_placeholder_prev = '<s-tab>'
        end
    },
}

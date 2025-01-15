return {
    {
        'github/copilot.vim',
        branch = 'release',
        config = function(_, _)
            vim.cmd[[
                let g:copilot_filetypes = {
                    \ 'markdown': v:false,
                    \ 'text': v:false
                    \ }
            ]]
        end
    }
}

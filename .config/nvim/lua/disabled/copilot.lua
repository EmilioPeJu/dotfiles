return {
    {
        'github/copilot.vim',
        branch = 'release',
        config = function(_, _)
            vim.cmd[[
                let g:copilot_filetypes = {
                    \ '*': v:false,
                    \ 'python': v:true,
                    \ 'c': v:true,
                    \ 'cpp': v:true,
                    \ 'nix': v:true,
                    \ 'vhdl': v:true
                    \ }
            ]]
        end
    }
}

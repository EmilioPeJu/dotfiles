return {
    {
        'github/copilot.vim',
        branch = 'release',
        config = function(_, _)
            vim.g.copilot_no_tab_map = true;
            vim.g.copilot_assume_mapped = true;
            vim.cmd[[
                let g:copilot_filetypes = {
                    \ '*': v:false,
                    \ 'python': v:true,
                    \ 'c': v:true,
                    \ 'cpp': v:true,
                    \ 'nix': v:true,
                    \ 'sh': v:true,
                    \ 'vhdl': v:true,
                    \ 'yaml': v:true
                    \ }
            ]]
        end
    }
}

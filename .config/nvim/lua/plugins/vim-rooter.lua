return {
    {
        'airblade/vim-rooter',
        config = function()
            vim.cmd("let g:rooter_targets = ['*src*', '*work*']")
        end
    }
}

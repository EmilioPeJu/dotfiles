return {
    {
        "chrisbra/csv.vim",
        lazy = false,
        ft = "csv",
        init = function()
            vim.cmd("filetype plugin on")
            vim.cmd("syntax on")
        end,
    }
}

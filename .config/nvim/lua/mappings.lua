local map = vim.keymap.set
map('n', '<ESC>', ':nohl<CR>')

-- Terminal
map('n', '<leader>t', ':terminal<CR>')
map('t', '<leader><ESC>', '<C-\\><C-n>', { noremap = true })

-- Function keys
map('n', '<F2>', ':NvimTreeToggle<CR>')
map('n', '<F3>', ':call QuickFix_toggle()<CR>')
map('n', '<F4>', ':TagbarToggle<CR>')
map('n', '<F5>', ':CocDiagnostics<CR>')

-- Window
map('n', '<C-j>', '<C-W>j', { noremap = true })
map('n', '<C-k>', '<C-W>k', { noremap = true })
map('n', '<C-h>', '<C-W>h', { noremap = true })
map('n', '<C-l>', '<C-W>l', { noremap = true })

-- Buffer
map('n', '<leader>q', ':bd<CR>')
map('n', '<leader>w', ':w<CR>')

-- Quickfix
map('n', '<leader>[', ':cp<CR>')
map('n', '<leader>]', ':cn<CR>')

-- Change directory
map('c', 'cd.', 'lcd %:p:h')
map('c', 'cdt', 
    function()
        local file_dir = vim.fn.expand('%:p:h')
        vim.cmd('lcd ' .. file_dir)
        local dot_git_path = vim.fn.finddir('.git', '.;')
        local new_dir = vim.fn.fnamemodify(dot_git_path, ':h')
        if new_dir ~= '' then
            vim.cmd('lcd ' .. new_dir)
        end
    end
)

-- Build helpers
map('n', '<leader>m', ':make<CR>')

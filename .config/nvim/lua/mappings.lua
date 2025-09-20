local map = vim.keymap.set
map('n', '<ESC>', ':nohl<CR>')
map('n', 'Y', 'yy')
map('n', '<leader>p', ":let @+=expand('%:p')<CR>")
map('i', '<C-l>',
  function ()
    vim.fn.feedkeys(vim.fn['copilot#Accept'](), '')
  end,
  { desc = 'Copilot Accept', noremap = true, silent = true })

-- Terminal
map('n', '<leader>t', ':ToggleTerm<CR>')
map('t', '<leader><ESC>', '<C-\\><C-n>', { noremap = true })
map('t', '<leader><leader>', '<C-\\><C-n>:Telescope buffers<CR>',
    { noremap = true })

-- Git fugitive
map('n', '<leader>gb', ":Git blame<CR>")
map('n', '<leader>gc', ":Gclog<CR>")
map('n', '<leader>gd', ":Git difftool<CR>")
map('n', '<leader>gm', ":Git mergetool<CR>")
map('n', '<leader>gl', ":Git log<CR>")
map('n', '<leader>gs', ":Gdiffsplit<CR>")

-- Function keys
map('n', '<F2>', ':NvimTreeToggle<CR>')
map('n', '<F4>', ':TagbarToggle<CR>')
map('n', '<F5>', ':Copilot panel<CR>')

-- Window
map('n', '<C-j>', '<C-W>j', { noremap = true })
map('n', '<C-k>', '<C-W>k', { noremap = true })
map('n', '<C-h>', '<C-W>h', { noremap = true })
map('n', '<C-l>', '<C-W>l', { noremap = true })
map('t', '<C-j>', '<C-\\><C-n><C-W>j', { noremap = true })
map('t', '<C-k>', '<C-\\><C-n><C-W>k', { noremap = true })
map('t', '<C-h>', '<C-\\><C-n><C-W>h', { noremap = true })
map('t', '<C-l>', '<C-\\><C-n><C-W>l', { noremap = true })

-- Buffer
map('n', '<leader>d', ':bn<CR>:bd!#<CR>')
map('n', '<leader>q', ':q<CR>')
map('n', '<leader>w', ':xa<CR>')

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

-- With leader key
map('n', '<leader>m', ':make<CR>')
map('n', '<leader>r', ':Ranger<CR>')

-- Tab
map('n', '<C-Left>', ':tabprevious<CR>')
map('n', '<C-Right>', ':tabnext<CR>')

return {
    {
        'L3MON4D3/LuaSnip',
        tag = 'v2.2.0',
        config = function(_, _)
            require('luasnip.loaders.from_lua').load({paths = '~/.config/nvim/LuaSnip/'})
            -- Keybindings
            vim.cmd[[
" Couldn't find a way to map this in lua
imap <silent><expr> <C-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>'
smap <silent><expr> <C-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>'
" The following mapping:s are provided in nvim-cmp config
"imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
"smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'
"imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
"smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
            ]]
        end
    }
}

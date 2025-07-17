return {
    {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ['<ESC>'] = cmp.mapping.close(),
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                    ['<C-l>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.mapping.confirm({ select = true, })(fallback)
                        elseif luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif require("copilot.suggestion").is_visible() then
                            require("copilot.suggestion").accept()
                        else
                            fallback()
                        end
                    end, {
                        'i',
                        's',
                    }),
                }),
                sources = cmp.config.sources({
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'copilot' },
                    { name = 'nvim_lsp' },
                }, {
                    { name = 'buffer' },
                }),
            }
        end,
        dependencies = {
            {
                'hrsh7th/cmp-nvim-lsp',
            },
            {
                'zbirenbaum/copilot-cmp',
            },
            {
                'saadparwaiz1/cmp_luasnip',
            },
            {
                'hrsh7th/cmp-path',
            },
            {
                'hrsh7th/cmp-buffer',
            },
        },
    }
}

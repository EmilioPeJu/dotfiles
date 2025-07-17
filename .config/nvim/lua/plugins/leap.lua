return {
    {
        'ggandor/leap.nvim',
        config = function(_, opts)
            local leap = require('leap')
            leap.create_default_mappings()
        end
    },
}

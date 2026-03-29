return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<Tab>", mode = {"n", "x", "o"},
            function()
              require("flash").treesitter({
                actions = { ["<Tab>"] = "next", ["<S-Tab>"] = "prev" }
              })
            end,
      },
    },
  },
}

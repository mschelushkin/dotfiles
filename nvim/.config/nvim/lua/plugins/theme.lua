return
--    {
--    "catppuccin/nvim",
--    name = "catppuccin",
--    lazy = false,
--    priority = 1000,
--    config = function()
--        vim.cmd.colorscheme "catppuccin-mocha"
--    end
--}

--{
--    "rose-pine/neovim",
--    name = "rose-pine",
--    config = function()
--        vim.cmd("colorscheme rose-pine-moon")
--    end
--},
{ "ellisonleao/gruvbox.nvim", priority = 1000 ,
    config = function()
        vim.cmd("colorscheme gruvbox")
    end
    }

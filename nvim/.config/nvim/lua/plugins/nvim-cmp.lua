return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            --            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets"
        },
        --        build = "make install_jsregexp"

    },
    {
        "hrsh7th/cmp-nvim-lsp"
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        --     -- this is equalent to setup({}) function
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            'windwp/nvim-autopairs',
        },
        config = function()
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()

            --vim.opt.completeopt = { "menu", "menuone", "noselect" }
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
            local kind = cmp.lsp.CompletionItemKind

            cmp.event:on('confirm_done', function(event)
                local entry = event.entry
                local item = entry:get_completion_item()
                local functionsig = item.label
                if item.kind == kind.Function or item.kind == kind.Method then
                    print("Test print 2")
                    if functionsig:sub(#functionsig - 1, #functionsig) == '()' then
                        vim.api.nvim_feedkeys(
                            vim.api.nvim_replace_termcodes('<C-g>U<right>', true, false, true)
                            , "n", false)
                    end
                end
            end)


            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "nvim_lua" },
                    --{ name = "luasnip" }, -- For luasnip users.
                    -- { name = "orgmode" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })

            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            require('lspconfig')['lua_ls'].setup {
                capabilities = capabilities
            }
        end
    }
}

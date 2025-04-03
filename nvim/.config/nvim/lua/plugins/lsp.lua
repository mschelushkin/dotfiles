return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "jdtls",
                    "ts_ls",
                    "gopls",
                    "lemminx",
                    "kotlin_language_server",
                    "pylsp",
                }
            })
        end
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts)
            require 'lsp_signature'.setup(opts)
            vim.keymap.set({ 'n' }, '<C-k>', function()
                require('lsp_signature').toggle_float_win()
            end, { silent = true, noremap = true, desc = 'toggle signature' })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            --local capabilities = vim.lsp.protocol.make_client_capabilities()
            --local capabilities = require('cmp_nvim_lsp').default_capabilities()
            lspconfig.lua_ls.setup({
                --capabilities = capabilities
            })
            lspconfig.ts_ls.setup({
                --capabilities = capabilities
            })
            lspconfig.gopls.setup({
                --capabilities = capabilities
            })
            lspconfig.sourcekit.setup({
            })
            lspconfig.lemminx.setup({
            })
            lspconfig.kotlin_language_server.setup({
            })
            lspconfig.pylsp.setup({
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                ignore = {'W391', 'E501'},
                                maxLineLength = 100
                            }
                        }
                    }
                }

            })

            --vim.lsp.set_log_level("debug")
            --lspconfig.jdtls.setup({})
            local telescope = require("telescope.builtin")
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', 'gi', telescope.lsp_implementations, opts)
                    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', telescope.lsp_references, opts)
                    --vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = 0 })
                    vim.keymap.set("n", "ga", vim.diagnostic.goto_next)
                    vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
                end
            })
        end
    },
--    {
--        'nvim-java/nvim-java',
--        config = false,
--        dependencies = {
--            {
--                "neovim/nvim-lspconfig",
--                opts = {
--                    servers = {
--                        jdtls = {
--                            -- your jdtls configuration goes here
--                        },
--                    },
--                    setup = {
--                        jdtls = function()
--                            require("java").setup({
--                                -- your nvim-java configuration goes here
--                            })
--                        end,
--                    },
--                },
--            },
--        },
--    },
        {
            "mfussenegger/nvim-jdtls",
                    ft = 'java',
            --        dependencies = { 'neovim/nvim-lspconfig' },
        }
}

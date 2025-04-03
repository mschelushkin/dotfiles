return {
    'stevearc/conform.nvim',
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                go = { "goimports", "gofmt" },
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                python = { "isort", "black" },
                -- Use a sub-list to run only the first available formatter
                javascript = { { "prettierd", "prettier" } },
                java = {"google-java-format"},
                json = {"jq"},
                sh = {"beautysh"}
            },
        })
        vim.keymap.set("", "<leader>f", function()
            require("conform").format({ async = true, lsp_fallback = true })
        end)
    end
}

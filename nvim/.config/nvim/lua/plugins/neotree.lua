return  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information,
    },
   -- opts = {
   --     filesystem = {
   --         bind_to_cwd = false,
   --         follow_current_file = { enabled = true },
   --         use_libuv_file_watcher = true,
   --     },
   -- },
    config = function()
        require('neo-tree').setup({
            filesystem = {
                follow_current_file = {
                    enabled = true, -- This will find and focus the file in the active buffer every time
                    --               -- the current file is changed while the tree is open.
                    leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                },
                filtered_items = {
                    visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
                    hide_dotfiles = false,
                    hide_gitignored = true,
                },

            }
        })
        vim.keymap.set("n", "<leader>ft", ":Neotree action=focus filesystem float toggle left<CR>", {})
        --require("neo-tree.command").execute({ toggle = true })
    end
}


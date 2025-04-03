local mason = require('mason-registry')
local jdtls_path = mason.get_package('jdtls'):get_install_path()

local system = 'mac'

local equinox_launcher_path = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
local config_path = vim.fn.glob(jdtls_path .. '/config_' .. system)
--local lombok_path = vim.fn.glob(jdtls_path .. '/lombok.jar')
local lombok_path = vim.fn.expand('~/Downloads/' .. '/lombok.jar')

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.expand('~/.local/share/java/workspace/' .. project_name)
--local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
--local capabilities =
--.default_capabilities(vim.lsp.protocol.make_client_capabilities())

local config = {
    --capabilities = capabilities,
    settings = {
        java = {
            -- format = {
            --     settings = {
            --         -- Use Google Java style guidelines for formatting
            --         -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
            --         -- and place it in the ~/.local/share/eclipse directory
            --         url = "/.local/share/eclipse/eclipse-java-google-style.xml",
            --         profile = "GoogleStyle",
            --     },
            -- },
            signatureHelp = { enabled = true },
            -- contentProvider = { preferred = 'fernflower' },  -- Use fernflower to decompile library code
            -- Specify any completion options
            -- completion = {
            --     favoriteStaticMembers = {
            --         "org.hamcrest.MatcherAssert.assertThat",
            --         "org.hamcrest.Matchers.*",
            --         "org.hamcrest.CoreMatchers.*",
            --         "org.junit.jupiter.api.Assertions.*",
            --         "java.util.Objects.requireNonNull",
            --         "java.util.Objects.requireNonNullElse",
            --         "org.mockito.Mockito.*"
            --     },
            --     filteredTypes = {
            --         "com.sun.*",
            --         "io.micrometer.shaded.*",
            --         "java.awt.*",
            --         "jdk.*", "sun.*",
            --     },
            -- },
            -- Specify any options for organizing imports
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            -- How code generation should act
            -- codeGeneration = {
            --     toString = {
            --         template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
            --     },
            --     hashCodeEquals = {
            --         useJava7Objects = true,
            --     },
            --     useBlocks = true,
            -- },
            -- If you are developing in projects with different Java versions, you need
            -- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
            -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
            -- And search for `interface RuntimeOption`
            -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = vim.fn.expand("~/.sdkman/candidates/java/17.0.4-amzn"),
                    },
                    {
                        name = "JavaSE-21",
                        path = vim.fn.expand("~/.sdkman/candidates/java/21-amzn"),
                    },
                }
            }
        }
    },
    cmd = {
        -- 💀
        'java', -- or '/path/to/java17_or_newer/bin/java'
        --'/Users/mchelushkin/.sdkman/candidates/java/21-amzn/bin/java',
        --                    --             path = home .. "/.sdkman/candidates/java/21-amzn",
        -- depends on if `java` is in your $PATH env variable and if it points to the right version.

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. lombok_path,
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        '-jar', equinox_launcher_path,
        '-configuration', config_path,

        '-data', workspace_dir
    },
    capabilites = require('cmp_nvim_lsp').default_capabilities(),
    --capabilities = require'cmp_nvim_lsp'.default_capabilities(),
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = true,
})
require "lsp_signature".setup({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
        border = "rounded"
    }
})

--local config = {
--    cmd = {jdtls_path .. '/bin/jdtls'},
--    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
--}
--require('jdtls').start_or_attach(config)

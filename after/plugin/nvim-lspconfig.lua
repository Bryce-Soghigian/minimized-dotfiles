local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>d", "<Cmd>Telescope diagnostics<cr>", opts)

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, bufopts)
    -- Prefer Telescope versions
    vim.keymap.set("n", "gd", "<Cmd>Telescope lsp_definitions<cr>", bufopts)
    vim.keymap.set("n", "gD", "<Cmd>Telescope lsp_type_definitions<cr>", bufopts)
    vim.keymap.set("n", "gi", "<Cmd>Telescope lsp_implementations<cr>", bufopts)
    vim.keymap.set("n", "gr", "<Cmd>Telescope lsp_references<cr>", bufopts)
    vim.keymap.set("n", "gs", "<Cmd>Telescope lsp_document_symbols<cr>", bufopts)
    vim.keymap.set("n", "<Shift><Shift>", "<Cmd>Telescope lsp_dynamic_workspace_symbols<cr>", bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<space>f", vim.lsp.buf.format, bufopts) -- Updated from `formatting`
end

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.gopls.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false }) -- Updated from `formatting_sync`
            end,
        })
    end,
}

-- **Replace sumneko_lua with lua_ls**
lspconfig.lua_ls.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false }) -- Updated from `formatting_sync`
            end,
        })
    end,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false, -- Recommended to avoid third-party warnings
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

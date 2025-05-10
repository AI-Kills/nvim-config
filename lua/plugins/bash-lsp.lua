return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                bashls = {
                    -- Use custom wrapper to suppress punycode deprecation warnings
                    -- This wrapper runs bash-language-server with Node's --no-deprecation flag
                    cmd = { "/Users/a.i./.local/bin/bash-language-server-wrapper", "start" },
                },
            },
        },
    },
}

local lspconfig = require('lspconfig')

local servers = {
	'lua_ls',

	'html',
	'cssls',
}

local ccpb = vim.lsp.protocol.make_client_capabilities()
ccpb.textDocument.completion.completionItem.snippetSupport = true

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		capabilities = ccpb,
	})
end

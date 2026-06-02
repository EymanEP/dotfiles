-- Neovim 0.11 native API: register aem_htl independently of lspconfig
vim.lsp.config("aem_htl", {
  cmd = { "node", vim.fn.expand("~") .. "/Projects/aem-htl-lsp/out/server.js", "--stdio" },
  filetypes = { "html" },
  root_markers = { "pom.xml", "ui.apps" },
})
vim.lsp.enable("aem_htl")

-- When the html LSP attaches, disable its completionProvider for AEM project buffers.
-- The html server treats `href="${button."` as a relative path and suggests sibling
-- files/folders. aem_htl owns all completions for HTL files; html keeps hover/formatting.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not (client and client.name == "html") then return end

    local bufname = vim.api.nvim_buf_get_name(args.buf)
    local is_aem = #vim.fs.find({ "ui.apps" }, {
      upward = true,
      path = vim.fn.fnamemodify(bufname, ":h"),
      type = "directory",
      limit = 1,
    }) > 0

    if is_aem then
      client.server_capabilities.completionProvider = nil
    end
  end,
})

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "html", "xml", "javascript" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {
          filetypes = { "html" },
          init_options = {
            configurationSection = { "html", "css", "javascript" },
            embeddedLanguages = { css = true, javascript = true },
            provideFormatter = true,
          },
        },
        xml = {
          format = { enabled = true, splitAttributes = true },
          completion = { autoCloseTags = true },
        },
      },
    },
  },
  -- Disable nvim-cmp path source for html files — it also suggests sibling files
  -- inside attribute values (e.g. href="${button.") which pollutes HTL completions.
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      local html_sources = vim.tbl_filter(function(s)
        return s.name ~= "path"
      end, opts.sources or {})
      cmp.setup.filetype("html", { sources = html_sources })
    end,
  },
}

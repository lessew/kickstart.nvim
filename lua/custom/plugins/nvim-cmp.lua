-- nvim-cmp configuration for markdown files (Obsidian completion)
-- This runs alongside blink.cmp which handles LSP completion

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  -- Only load for markdown files
  ft = "markdown",
  config = function()
    local cmp = require("cmp")
    
    -- Setup nvim-cmp only for markdown buffers
    cmp.setup.filetype("markdown", {
      sources = cmp.config.sources({
        { name = "obsidian" },
        { name = "obsidian_new" },
        { name = "obsidian_tags" },
        { name = "buffer" },
        { name = "path" },
      }),
      
      mapping = cmp.mapping.preset.insert({
        -- Tab to select next item
        ["<Tab>"] = cmp.mapping.select_next_item(),
        -- Shift-Tab to select previous item
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        -- Enter to confirm
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        -- Ctrl-Space to trigger completion
        ["<C-Space>"] = cmp.mapping.complete(),
        -- Ctrl-e to abort
        ["<C-e>"] = cmp.mapping.abort(),
      }),
      
      -- Completion window appearance
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      
      -- Formatting
      formatting = {
        format = function(entry, vim_item)
          -- Show source name
          vim_item.menu = ({
            obsidian = "[Obsidian]",
            obsidian_new = "[New]",
            obsidian_tags = "[Tag]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]
          return vim_item
        end,
      },
    })
  end,
}


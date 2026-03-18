-- Which-key.nvim - Shows pending keybinds
-- Displays a popup with possible key bindings when you start typing a command
--
-- This is the CENTRAL place for all leader key group definitions
-- Individual keymaps are defined in their respective plugin files

return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },

    -- Document existing key chains
    spec = {
      -- Search (Telescope) - lua/custom/plugins/telescope.lua
      { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },

      -- Toggle - various plugins
      --      { '<leader>t', group = '[T]oggle' },

      -- Git (Gitsigns) - lua/custom/plugins/gitsigns.lua
      { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },

      -- Obsidian - lua/custom/plugins/obsidian.lua
      { '<leader>o', group = '[O]bsidian' },

      { '<leader>h', group = '[H]arpoon' },

      -- Individual keymaps (no group needed):
      -- <leader>a - Harpoon: Add file
      -- <leader>m - Harpoon: Menu
      -- <leader>tt - Terminal: Toggle
    },
  },
}

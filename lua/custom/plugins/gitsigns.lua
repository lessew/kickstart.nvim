-- Gitsigns.nvim - Git decorations and utilities
-- Shows git changes in the gutter, inline blame, and more

return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '│' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
  },

  -- Keymaps
  config = function(_, opts)
    local gitsigns = require 'gitsigns'
    gitsigns.setup(opts)

    -- Navigation between hunks
    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'Next git [c]hange' })

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'Previous git [c]hange' })

    -- Actions (all under <leader>g for [G]it)
    vim.keymap.set('n', '<leader>gs', gitsigns.stage_hunk, { desc = '[G]it [s]tage hunk' })
    vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[G]it [r]eset hunk' })
    vim.keymap.set('v', '<leader>gs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = '[G]it [s]tage hunk' })
    vim.keymap.set('v', '<leader>gr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = '[G]it [r]eset hunk' })
    vim.keymap.set('n', '<leader>gS', gitsigns.stage_buffer, { desc = '[G]it [S]tage buffer' })
    vim.keymap.set('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = '[G]it [u]ndo stage' })
    vim.keymap.set('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[G]it [R]eset buffer' })
    vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, { desc = '[G]it [p]review hunk' })
    vim.keymap.set('n', '<leader>gb', function() gitsigns.blame_line{full=true} end, { desc = '[G]it [b]lame line' })
    vim.keymap.set('n', '<leader>gB', gitsigns.toggle_current_line_blame, { desc = '[G]it toggle [B]lame' })
    vim.keymap.set('n', '<leader>gd', gitsigns.diffthis, { desc = '[G]it [d]iff' })
    vim.keymap.set('n', '<leader>gD', function() gitsigns.diffthis('~') end, { desc = '[G]it [D]iff ~' })

    -- Text object
    vim.keymap.set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select git hunk' })
  end,
}

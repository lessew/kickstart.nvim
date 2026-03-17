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

    -- Actions
    --vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Git [h]unk [s]tage' })
    --vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Git [h]unk [r]eset' })
    --vim.keymap.set('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Git [h]unk [s]tage' })
    --vim.keymap.set('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Git [h]unk [r]eset' })
    --vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Git [h]unk [S]tage buffer' })
    --vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Git [h]unk [u]ndo stage' })
    --vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Git [h]unk [R]eset buffer' })
    vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Git [h]unk [p]review' })
    --vim.keymap.set('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, { desc = 'Git [h]unk [b]lame line' })
    --vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git [b]lame' })
    --vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, { desc = 'Git [h]unk [d]iff' })
    --vim.keymap.set('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = 'Git [h]unk [D]iff ~' })
    --vim.keymap.set('n', '<leader>td', gitsigns.toggle_deleted, { desc = '[T]oggle git [d]eleted' })

    -- Text object
    --vim.keymap.set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select git hunk' })
  end,
}

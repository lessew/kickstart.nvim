-- Technicall nog a plugin!
-- Provides a simple terminal toggle with <leader>tt

-- Terminal state
local terminal_bufnr = nil
local terminal_winnr = nil

-- Toggle terminal function
local function toggle_terminal()
  -- Check if terminal window is open
  if terminal_winnr and vim.api.nvim_win_is_valid(terminal_winnr) then
    -- Close the terminal window
    vim.api.nvim_win_close(terminal_winnr, false)
    terminal_winnr = nil
  else
    -- Open terminal in horizontal split
    vim.cmd 'split'
    if terminal_bufnr and vim.api.nvim_buf_is_valid(terminal_bufnr) then
      -- Reuse existing terminal buffer
      vim.api.nvim_win_set_buf(0, terminal_bufnr)
    else
      -- Create new terminal
      vim.cmd 'terminal'
      terminal_bufnr = vim.api.nvim_get_current_buf()
    end
    terminal_winnr = vim.api.nvim_get_current_win()
    -- Enter insert mode in terminal
    vim.cmd 'startinsert'
  end
end

-- Terminal keymaps
vim.keymap.set('n', '<leader>tt', toggle_terminal, { desc = '[T]oggle [T]erminal' })
vim.keymap.set('t', '<leader>tt', toggle_terminal, { desc = '[T]oggle [T]erminal' })

-- Exit terminal mode shortcuts
vim.keymap.set('t', '<C-x>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Terminal mode window navigation
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Move focus to the upper window' })

-- Return empty table for lazy.nvim (this file doesn't define a plugin)
return {}

-- Obsidian.nvim plugin configuration
-- For writing and navigating Obsidian vaults in Neovim

return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required
    "nvim-lua/plenary.nvim",
    -- Optional (already in your config)
    "nvim-telescope/telescope.nvim",
    -- For completion
    "hrsh7th/nvim-cmp",
  },

  -- Set conceallevel when entering markdown files in vault
  init = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*/vault-*/*.md",
      callback = function()
        vim.opt_local.conceallevel = 1
      end,
    })
  end,

  opts = {
    -- Workspaces - automatically detect vault-* folders
    workspaces = {
      {
        name = "simplicate",
        path = "~/dmmhp/sync/gdrive/vault-simplicate",
      },
      -- Add more vaults here if you create them later
      -- {
      --   name = "vault-name",
      --   path = "~/dmmhp/sync/gdrive/vault-name",
      -- },
    },

    -- Disable daily notes (you use Journal.md instead)
    daily_notes = {
      folder = nil,
    },

    -- Disable templates
    templates = {
      folder = nil,
    },

    -- Use markdown link style instead of wiki links
    preferred_link_style = "markdown",

    -- Enable nvim-cmp completion for Obsidian
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    -- Don't create new notes in a specific subfolder
    new_notes_location = "current_dir",

    -- Disable frontmatter if you don't use it
    disable_frontmatter = false,

    -- Use telescope for picking
    picker = {
      name = "telescope.nvim",
    },

    -- Sort by modified time (most recent first)
    sort_by = "modified",
    sort_reversed = true,

    -- Follow external URLs in browser
    follow_url_func = function(url)
      vim.fn.jobstart({"open", url})  -- Mac OS
    end,

    -- UI settings for better markdown experience
    ui = {
      enable = true,
      update_debounce = 200,
      checkboxes = {
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        ["!"] = { char = "", hl_group = "ObsidianImportant" },
      },
      bullets = { char = "•", hl_group = "ObsidianBullet" },
      external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      reference_text = { hl_group = "ObsidianRefText" },
      highlight_text = { hl_group = "ObsidianHighlightText" },
      tags = { hl_group = "ObsidianTag" },
    },

    -- Keymaps - minimal set, we'll configure more based on your needs
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown links within your vault
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },
  },

  -- Additional keymaps (not buffer-specific)
  keys = {
    -- Search in vault
    { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "[O]bsidian [S]earch" },
    -- Quick switch between notes
    { "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "[O]bsidian [Q]uick switch" },
    -- Show backlinks
    { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "[O]bsidian [B]acklinks" },
  },
}


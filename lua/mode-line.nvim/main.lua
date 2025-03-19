local M = {}
local api = vim.api
local config = require("mode-line.nvim.config")

-- Default border styles for different modes
local default_borders = {
  normal = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
  insert = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
  visual = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  replace = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
  command = { "█", "█", "█", "█", "█", "█", "█", "█" },
  terminal = { "╒", "═", "╕", "│", "╛", "═", "╘", "│" },
}

-- Function to update the border of the current window based on mode
function M.update_border()
  local mode = api.nvim_get_mode().mode
  local mode_name = ""
  
  -- Map mode character to mode name
  if mode == "n" then
    mode_name = "normal"
  elseif mode == "i" then
    mode_name = "insert"
  elseif mode:find("v") or mode:find("V") or mode == "\22" then -- Visual modes
    mode_name = "visual"
  elseif mode == "R" then
    mode_name = "replace"
  elseif mode == "c" then
    mode_name = "command"
  elseif mode == "t" then
    mode_name = "terminal"
  else
    mode_name = "normal" -- Default to normal for other modes
  end
  
  -- Get border style for current mode
  local border = M.config.borders[mode_name] or default_borders[mode_name]
  
  -- Get current window
  local win = api.nvim_get_current_win()
  
  -- Update window border
  api.nvim_win_set_config(win, {
    border = border
  })
end

-- Setup autocommands to update border on mode changes
function M.setup_autocmds()
  local augroup = api.nvim_create_augroup("ModeLine", { clear = true })
  
  -- Update border when mode changes
  api.nvim_create_autocmd("ModeChanged", {
    group = augroup,
    pattern = "*",
    callback = M.update_border,
  })
  
  -- Update border when window changes
  api.nvim_create_autocmd("WinEnter", {
    group = augroup,
    pattern = "*",
    callback = M.update_border,
  })
end

-- Initialize the plugin
function M.setup(opts)
  -- Merge user config with defaults
  M.config = vim.tbl_deep_extend("force", {
    enabled = true,
    borders = default_borders,
  }, opts or {})
  
  if M.config.enabled then
    M.setup_autocmds()
    -- Initial border update
    M.update_border()
  end
end

return M


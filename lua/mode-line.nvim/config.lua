local M = {}

M.defaults = {
  enabled = true,
  borders = {
    normal = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
    insert = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
    visual = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    replace = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
    command = { "█", "█", "█", "█", "█", "█", "█", "█" },
    terminal = { "╒", "═", "╕", "│", "╛", "═", "╘", "│" },
  }
}

return M


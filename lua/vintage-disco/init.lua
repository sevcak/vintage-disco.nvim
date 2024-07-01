local util = require("vintage-disco.util")
local theme = require("vintage-disco.theme")
local config = require("vintage-disco.config")

local M = {}

function M._load(style)
  if style and not M._style then
    M._style = require("vintage-disco.config").options.style
  end
  if not style and M._style then
    require("vintage-disco.config").options.style = M._style
    M._style = nil
  end
  M.load({ style = style, use_background = style == nil })
end

---@param opts Config|nil
function M.load(opts)
  if opts then
    require("vintage-disco.config").extend(opts)
  end
  util.load(theme.setup())
end

M.setup = config.setup

-- keep for backward compatibility
M.colorscheme = M.load

return M

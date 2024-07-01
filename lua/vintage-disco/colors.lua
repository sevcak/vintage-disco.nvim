local util = require("vintage-disco.util")
local hslutil = require("vintage-disco.hsl")
local hsl = hslutil.hslToHex

local M = {}

---@class Palette
M.default = {
  none = "NONE",

  base04 = hsl(25, 33, 36),
  base03 = hsl(24, 25, 51),
  base02 = hsl(29, 24, 64),
  base01 = hsl(25, 43, 30),
  base00 = hsl(43, 87, 94),
  -- base0 = hsl( 186, 8, 55 ),
  base0 = hsl(43, 87, 94),
  -- base1 = hsl( 180, 7, 60 ),
  base1 = hsl(43, 87, 94),
  base2 = hsl(46, 42, 88),
  base3 = hsl(44, 87, 94),
  base4 = hsl(0, 0, 100),
  yellow = hsl(54, 100, 58),
  yellow100 = hsl(47, 100, 80),
  yellow300 = hsl(54, 100, 65),
  yellow500 = hsl(45, 100, 50),
  yellow700 = hsl(45, 100, 35),
  yellow900 = hsl(45, 100, 20),
  orange = hsl(29, 100, 58),
  orange100 = hsl(29, 100, 74),
  orange300 = hsl(29, 100, 64),
  orange500 = hsl(29, 100, 50),
  orange700 = hsl(19, 100, 43),
  orange900 = hsl(29, 100, 29),
  red = hsl(0, 100, 60),
  red100 = hsl(0, 98, 75),
  red300 = hsl(0, 100, 68),
  red500 = hsl(0, 95, 55),
  red700 = hsl(0, 63, 49),
  red900 = hsl(0, 71, 32),
  magenta = hsl(317, 100, 68),
  magenta100 = hsl(317, 90, 83),
  magenta300 = hsl(317, 83, 70),
  magenta500 = hsl(317, 90, 61),
  magenta700 = hsl(317, 86, 48),
  magenta900 = hsl(317, 99, 36),
  violet = hsl(259, 100, 83),
  violet100 = hsl(259, 95, 90),
  violet300 = hsl(259, 86, 75),
  violet500 = hsl(259, 96, 72),
  violet700 = hsl(259, 87, 61),
  violet900 = hsl(259, 57, 46),
  blue = hsl(223, 100, 80),
  blue100 = hsl(220, 100, 72),
  blue300 = hsl(205, 90, 62),
  blue500 = hsl(205, 69, 49),
  blue700 = hsl(205, 70, 35),
  blue900 = hsl(205, 69, 20),
  cyan = hsl(175, 75, 64),
  cyan100 = hsl(176, 100, 86),
  cyan300 = hsl(175, 85, 55),
  cyan500 = hsl(182, 54, 47),
  cyan700 = hsl(182, 59, 25),
  cyan900 = hsl(183, 58, 15),
  green = hsl(68, 100, 68),
  green100 = hsl(90, 100, 84),
  green300 = hsl(76, 100, 49),
  green500 = hsl(68, 100, 40),
  green700 = hsl(68, 100, 20),
  green900 = hsl(68, 100, 10),

  bg = hsl(20, 23, 26),
  bg_highlight = hsl(23, 37, 64),
  fg = hsl(43, 87, 94),
}

---@return ColorScheme
function M.setup(opts)
  opts = opts or {}
  local config = require("vintage-disco.config")

  -- local style = config.is_day() and config.options.light_style or config.options.style
  local style = "default"
  local palette = M[style] or {}
  if type(palette) == "function" then
    palette = palette()
  end

  -- Color Palette
  ---@class ColorScheme: Palette
  local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)

  util.bg = colors.bg
  util.day_brightness = config.options.day_brightness

  colors.black = util.darken(colors.bg, 0.8, "#000000")
  colors.border = colors.black

  -- Popups and statusline always get a dark background
  colors.bg_popup = colors.base04
  colors.bg_statusline = colors.base03

  -- Sidebar and Floats are configurable
  colors.bg_sidebar = config.options.styles.sidebars == "transparent" and colors.none
    or config.options.styles.sidebars == "dark" and colors.base04
    or colors.bg

  colors.bg_float = config.options.styles.floats == "transparent" and colors.none
    or config.options.styles.floats == "dark" and colors.base04
    or colors.bg

  -- colors.fg_float = config.options.styles.floats == "dark" and colors.base01 or colors.fg
  colors.fg_float = colors.fg

  colors.error = colors.red500
  colors.warning = colors.yellow500
  colors.info = colors.blue500
  colors.hint = colors.cyan500
  colors.todo = colors.violet500

  config.options.on_colors(colors)
  if opts.transform and config.is_day() then
    util.invert_colors(colors)
  end

  return colors
end

return M

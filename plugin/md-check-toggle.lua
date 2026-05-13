if vim.fn.exists('g:loaded_md_check_toggle') == 1 then
  return
end
vim.g:loaded_md_check_toggle = 1

local md_check = require("md-check-toggle")

-- Create the global command
vim.api.nvim_create_user_command("MDCheckToggle", function(args)
  md_check.toggle({ range = args.range > 0, line1 = args.line1, line2 = args.line2 })
end, { range = true, desc = "Toggle Markdown checkmark" })

local md_check = require("md-check-toggle")

-- Only set the mapping if it's not disabled
if md_check.config and md_check.config.mapping ~= false then
  local mapping = (md_check.config and md_check.config.mapping) or "<leader>cc"
  vim.keymap.set({ "n", "v" }, mapping, md_check.toggle, { buffer = true, desc = "Toggle Markdown checkmark" })
end

-- Always create the command as a buffer-local command if preferred, 
-- but the global command is already created in setup.

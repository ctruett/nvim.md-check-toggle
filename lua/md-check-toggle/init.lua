local M = {}

M.config = {
  states = { "[ ]", "[x]" },
  mapping = "<leader>cc",
}

local function get_next_state(current_state, states)
  for i, state in ipairs(states) do
    if current_state == state or (state == "[x]" and current_state == "[X]") then
      local next_index = (i % #states) + 1
      return states[next_index]
    end
  end
  return nil
end

function M.toggle_line(line)
  for _, state in ipairs(M.config.states or { "[ ]", "[x]" }) do
    -- Escape special characters for Lua patterns
    local pattern = state:gsub("([%[%]%(%)%.%+%-%*%?%^%$%%])", "%%%1")
    if line:find(pattern) then
      local next_state = get_next_state(state, M.config.states)
      if next_state then
        -- We need to escape the search pattern but NOT the replacement string (mostly)
        -- Actually, gsub replacement string has some special chars (%)
        local escaped_next = next_state:gsub("%%", "%%%%")
        return line:gsub(pattern, escaped_next, 1)
      end
    end
  end

  -- Fallback for [X] if not in states explicitly
  if line:find("%[X%]") then
    local next_state = get_next_state("[x]", M.config.states)
    if next_state then
      return line:gsub("%[X%]", next_state:gsub("%%", "%%%%"), 1)
    end
  end

  return line
end

function M.toggle(opts)
  opts = opts or {}
  local start_line, end_line

  if opts.range then
    start_line = opts.line1
    end_line = opts.line2
  else
    local mode = vim.api.nvim_get_mode().mode
    if mode:match("[vV\22]") then
      local start_pos = vim.fn.getpos("v")
      local end_pos = vim.fn.getpos(".")
      start_line = math.min(start_pos[2], end_pos[2])
      end_line = math.max(start_pos[2], end_pos[2])
    end
  end

  if start_line and end_line then
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    for i, line in ipairs(lines) do
      lines[i] = M.toggle_line(line)
    end
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
  else
    -- Normal mode
    local line = vim.api.nvim_get_current_line()
    local new_line = M.toggle_line(line)
    if new_line ~= line then
      vim.api.nvim_set_current_line(new_line)
    end
  end
end

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})

  if M.config.mapping then
    -- We don't set the mapping globally here anymore, 
    -- as it's handled by ftplugin for markdown files.
    -- But if the user wants it globally, they could do it themselves 
    -- or we can provide an option.
  end
end

return M

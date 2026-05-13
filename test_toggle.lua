-- test_toggle.lua
-- Add plugin to runtimepath for the test
vim.opt.rtp:append(".")

local md_check = require("md-check-toggle")

local function test(input, expected, description)
    vim.api.nvim_set_current_line(input)
    md_check.toggle()
    local result = vim.api.nvim_get_current_line()
    if result == expected then
        print(string.format("Success: [%s] '%s' -> '%s'", description or "test", input, result))
    else
        print(string.format("Failure: [%s] '%s' -> '%s' (expected '%s')", description or "test", input, result, expected))
        os.exit(1)
    end
end

print("Testing default states:")
test("- [ ] task", "- [x] task", "basic toggle")
test("- [x] task", "- [ ] task", "toggle back")
test("  * [ ] indented", "  * [x] indented", "indented")
test("1. [X] capital X", "1. [ ] capital X", "capital X")
test("no checkmark", "no checkmark", "no checkmark")

print("\nTesting custom states:")
md_check.setup({
    states = { "[ ]", "[/]", "[x]" }
})

test("- [ ] task", "- [/] task", "custom state 1")
test("- [/] task", "- [x] task", "custom state 2")
test("- [x] task", "- [ ] task", "custom state cycle")

print("\nAll tests passed!")

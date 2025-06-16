local template_dir = "/Users/colin/ctf-notebook/canned"

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local function run_selection(prompt_bufnr, map)
    actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local file = action_state.get_selected_entry()

        if #file > 0 then
            local file_path = template_dir .. "/" .. file[1]
            local content = vim.fn.readfile(file_path)

            vim.fn.append(vim.fn.line("."), content)
        end

    end)
    return true
end

local function CannedCTF()
    local file = require("telescope.builtin").find_files({
        cwd = template_dir,
        previewer = true,
        attach_mappings = run_selection
    })
end

-- Creates an object for the module. All of the module's
-- functions are associated with this object, which is
-- returned when the module is called with `require`.
local M = {}

-- Routes calls made to this module to functions in the
-- plugin's other modules.
M.run = CannedCTF

return M

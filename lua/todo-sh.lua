-- LazyGit💤

-- version 2.0

local M = {}

M.state = {
    floating = {
        buf = -1,
        win = -1,
    },
}

---@param opts table -- table of opts for `:h nvim_create_buf`
---@return table -- return { buf = buf, win = win }
function M.toggle_float(opts)
    opts = opts or {}
    local x = opts.x or 0.9
    local y = opts.y or 0.9
    local conf = {
        relative = "editor",
        width = math.floor(vim.o.columns * x),
        height = math.floor(vim.o.lines * y),
        col = math.floor(vim.o.columns * ((1 - x) / 2)),
        row = math.floor(vim.o.lines * ((1 - y) / 2)),
        border = "rounded",
    }

    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true) -- buffer be like
    end

    local win_conf = conf -- use custom.dimension to get window stats
    local win = vim.api.nvim_open_win(buf, true, win_conf)

    return { buf = buf, win = win }
end

-- TODO:
---Create dir at specified todo.sh dir, write and load config, and action
---
-- M.todoshFiles = function()
--     local todoshFileExec = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), "%:h") --
--         .. "../assets/todo_sh/todo.sh_loop.bash"
--
--     local todoshDir = vim.fn.stdpath("state") .. "/todo-sh"
--     vim.uv.fs_mkdir(todoshDir, tonumber("755", 8)) -- specify and create state-dir
--
--     local todoshConfStr = require("todo-sh-config")
--     local todoshConfPath = todoshDir .. "/todo.cfg"
--     local todoshConfWrite, err = io.open(todoshConfPath, "w") -- "w" = write (truncate)
--     if not todoshConfWrite then
--         error(err)
--     end
--     todoshConfWrite:write(todoshConfStr)
--     todoshConfWrite:close()
-- end

local todoshAssets = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), "%:h") --
    .. "../assets/todo_sh/"
local todoshFileExec = todoshAssets .. "todo.sh_loop.bash"
local todoshFileConf = todoshAssets .. "todo.cfg"

local todoshLocalDir = vim.fn.stdpath("state") .. "/todo-sh"
vim.uv.fs_mkdir(todoshLocalDir, tonumber("755", 8)) -- specify and create state-dir

---Open the buffer with a `todo.sh` while loop.
function M.toggle_todo()
    if vim.api.nvim_win_is_valid(M.state.floating.win) then -- if visible
        vim.api.nvim_win_hide(M.state.floating.win) -- hide
    else
        M.state.floating = M.toggle_float({
            x = 0.8,
            y = 0.8,
            buf = M.state.floating.buf,
        }) -- tells it to use the same buffer
        if vim.bo[M.state.floating.buf].buftype ~= "terminal" then -- if buftype isn't terminal
            vim.cmd.terminal("bash -c " .. todoshFileExec .. " " .. todoshFileConf)
        end
    end
    vim.cmd("startinsert")
end

M.setup = function()
    vim.api.nvim_create_user_command("Todosh", M.toggle_todo, {})

    vim.keymap.set({ "n", "t" }, "<leader>ot", "<CMD>Todosh<CR>")
end

return M

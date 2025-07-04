-- This file contains custom key mappings for Neovim.

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Map CapsLock to Escape in normal, insert, and visual modes
-- vim.keymap.set({ "i", "v" }, "<CapsLock>", "<ESC>", { noremap = true, silent = true })

-- Position cursor at the middle of the screen after scrolling half page
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Scroll down half a page and center the cursor
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Scroll up half a page and center the cursor

-- Map Ctrl+b in insert mode to delete to the end of the word without leaving insert mode
vim.keymap.set("i", "<C-b>", "<C-o>de")

-- Map Ctrl+c to escape from other modes
vim.keymap.set({ "i", "n", "v" }, "<C-c>", [[<C-\><C-n>]])

-- Screen Keys
vim.keymap.set({ "n" }, "<leader>uk", "<cmd>Screenkey<CR>")

-- disable arrow keys in normal mode
vim.keymap.set("n", "<Up>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Left>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Right>", "<Nop>", { noremap = true, silent = true })

----- OBSIDIAN -----
vim.keymap.set("n", "<leader>oc", "<cmd>ObsidianCheck<CR>", { desc = "Obsidian Check Checkbox" })
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Obsidian Template" })
vim.keymap.set("n", "<leader>oo", "<cmd>Obsidian Open<CR>", { desc = "Open in Obsidian App" })
vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show ObsidianBacklinks" })
vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show ObsidianLinks" })
vim.keymap.set("n", "<leader>ow", "<cmd>ObsidianWorkspace<CR>", { desc = "Switch Workspace" })
-- vim.keymap.set("n", "<leader>or", "<cmd>ObsidianRename<CR>", { desc = "Rename Note" })
-- vim.keymap.set("n", "<leader>ooc", "<cmd>ObsidianTOC<CR>", { desc = "Load Table of Content" })
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" })
vim.keymap.set("n", "<leader>of", "<cmd>ObsidianNewFromTemplate<CR>", { desc = "Create New Note from Template" })
vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian" })
vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick Switch" })

------- MOVE SELECTED ELEMENTS IN VISUAL MODE --------
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected down" }) -- Move selected text down
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected up" }) -- Move selected text up

----- OIL -----
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Delete all buffers but the current one
vim.keymap.set(
  "n",
  "<leader>bq",
  '<Esc>:%bdelete|edit #|normal`"<Return>',
  { desc = "Delete other buffers but the current one" }
)

-- Disable key mappings in insert mode
vim.api.nvim_set_keymap("i", "<A-j>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-k>", "<Nop>", { noremap = true, silent = true })

-- Disable key mappings in normal mode
vim.api.nvim_set_keymap("n", "<A-j>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", "<Nop>", { noremap = true, silent = true })

-- Disable key mappings in visual block mode
vim.api.nvim_set_keymap("x", "<A-j>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-k>", "<Nop>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("x", "J", "<Nop>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("x", "K", "<Nop>", { noremap = true, silent = true })

-- Redefine Ctrl+s to save with the custom function
vim.api.nvim_set_keymap("n", "<C-s>", ":lua SaveFile()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:lua SaveFile()<CR>", { noremap = true, silent = true })

-- Enhanced custom save function
function SaveFile()
  local bufname = vim.api.nvim_buf_get_name(0)
  local filename = vim.fn.expand("%:t") -- Only the file name

  -- If it's a new buffer or terminal
  if bufname == "" or bufname:match("^term://") then
    vim.ui.input({
      prompt = "Save as: ",
      default = vim.fn.getcwd() .. "/",
    }, function(input)
      if input and input ~= "" then
        -- Escape path
        local escaped = vim.fn.fnameescape(input)
        local ok, err = pcall(function()
          vim.cmd("silent! write " .. escaped)
        end)
        if ok then
          vim.notify("File saved as: " .. input, vim.log.levels.INFO)
        else
          vim.notify("Error saving: " .. err, vim.log.levels.ERROR)
        end
      else
        vim.notify("Save cancelled", vim.log.levels.WARN)
      end
    end)
    return
  end

  -- Save existing file
  local ok, err = pcall(function()
    vim.cmd("silent! write")
  end)
  if ok then
    vim.notify(filename ~= "" and (filename .. " saved!") or "File saved!", vim.log.levels.INFO)
  else
    vim.notify("Error saving: " .. err, vim.log.levels.ERROR)
  end
end

local has_harpoon, harpoon = pcall(require, 'harpoon')

require("harpoon").setup({
    global_settings = {
        save_on_toggle = false
    }
})

if has_harpoon then
    harpoon.setup {
        global_settings = {
            save_on_toggle = false
        }
    }

    local opt = { noremap = true }
    vim.api.nvim_set_keymap("n", "<leader>a", ":lua require('harpoon.mark').add_file()<CR>", opt)
    vim.api.nvim_set_keymap("n", "<leader>e", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opt)

    vim.api.nvim_set_keymap("n", "<leader>hy", ":lua require('harpoon.ui').nav_file(1)<CR>", opt)
    vim.api.nvim_set_keymap("n", "<leader>hn", ":lua require('harpoon.ui').nav_file(2)<CR>", opt)
    vim.api.nvim_set_keymap("n", "<leader>he", ":lua require('harpoon.ui').nav_file(3)<CR>", opt)
    vim.api.nvim_set_keymap("n", "<leader>ho", ":lua require('harpoon.ui').nav_file(4)<CR>", opt)

    vim.api.nvim_set_keymap("n", "<leader>ty", ":lua require('harpoon.term').gotoTerminal(1)<CR>", opt)
    vim.api.nvim_set_keymap("n", "<leader>tn", ":lua require('harpoon.term').gotoTerminal(1)<CR>", opt)

end


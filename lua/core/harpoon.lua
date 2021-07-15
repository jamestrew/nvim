local has_harpoon, harpoon = pcall(require, 'harpoon')
if has_harpoon then
    harpoon.setup {
        global_settings = {
            save_on_toggle = false
        }
    }
end


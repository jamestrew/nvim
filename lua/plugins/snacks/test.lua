local cwd = vim.uv.cwd()


Snacks.picker({
  ---@type snacks.picker.finder
  finder = function(opts, ctx)
    local res = require("snacks.picker.source.proc").proc({
      opts,
      {
        cmd = "fd",
        args = {
          "--type",
          "f",
          "--type",
          "d",
          "--maxdepth",
          "1",
          "--hidden",
          "--no-ignore-vcs",
          "--color=never",
        },
        notify = not opts.live,
        ---@param item snacks.picker.finder.Item
        transform = function(item)
          item.cwd = cwd
          item.file = item.text
          item.dir = vim.fn.isdirectory(item.file) == 1
        end,
      },
    }, ctx)
    return res
  end,
  title = "File Browser",
  sort = {},
  layout = "ivy",
})
